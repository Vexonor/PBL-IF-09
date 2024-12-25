import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({super.key});

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    setState(() {
      _isLocationEnabled = permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    });
  }

  void _toggleLocationPermission(bool value) {
    if (value) {
      _requestLocationPermission();
    } else {
      // Jika pengguna mematikan switch, kita tidak bisa mengubah status izin lokasi
      // Namun, kita bisa mengatur status lokal menjadi false
      setState(() {
        _isLocationEnabled = false;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Tampilkan dialog untuk memberi tahu pengguna
      _showPermissionDeniedDialog();
    } else {
      // Jika izin diberikan, perbarui status slider
      setState(() {
        _isLocationEnabled = true; // Atur ke true jika izin diberikan
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Izin Lokasi Diperlukan'),
          content: Text(
              'Anda telah menolak izin lokasi. Untuk mengaktifkannya, silakan buka pengaturan aplikasi dan aktifkan izin lokasi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                // Arahkan pengguna ke pengaturan aplikasi
                Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
              child: Text('Pengaturan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Pengaturan Umum',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Atur preferensi aplikasi umum Anda untuk meningkatkan pengalaman pengguna.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.notifications_on,
                            judul: 'Notifikasi Push',
                            rute: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.notification_important,
                            judul: 'Notifikasi Pengaduan',
                            rute: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.circle_notifications,
                            judul: 'Notifikasi Informasi Pengangkutan',
                            rute: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.edit_notifications,
                            judul: 'Notifikasi Edukasi',
                            rute: () {},
                          ),
                          const SizedBox(height: 10),
                          _buildLocationPermissionSetting(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPermissionSetting() {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          'Izin Lokasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: Switch(
          value: _isLocationEnabled,
          onChanged: (value) {
            _toggleLocationPermission(value);
          },
        ),
      ),
    );
  }

  Widget _buildDaftarPengaturanNotifikasi({
    required IconData icon,
    required String judul,
    required Function() rute,
    Color color = Colors.black87,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          judul,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        onTap: rute,
      ),
    );
  }
}
