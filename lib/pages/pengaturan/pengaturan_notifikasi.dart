import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaturanNotifikasi extends StatefulWidget {
  const PengaturanNotifikasi({super.key});

  @override
  State<PengaturanNotifikasi> createState() => _PengaturanNotifikasiState();
}

class _PengaturanNotifikasiState extends State<PengaturanNotifikasi> {
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
        title: Text(
          'Kembali',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
          ),
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
                    'Pengaturan Notifikasi',
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
                            'Atur bagaimana Anda ingin menerima berbagai notifikasi yang tersedia',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.notifications_on,
                            title: 'Notifikasi Push',
                            onTap: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.notification_important,
                            title: 'Notifikasi Laporan',
                            onTap: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.circle_notifications,
                            title: 'Notifikasi Informasi Pengangkutan',
                            onTap: () {},
                          ),
                          _buildDaftarPengaturanNotifikasi(
                            icon: Icons.edit_notifications,
                            title: 'Notifikasi Edukasi',
                            onTap: () {},
                          ),
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

  Widget _buildDaftarPengaturanNotifikasi({
    required IconData icon,
    required String title,
    required Function() onTap,
    Color color = Colors.black87,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
