import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/pages/settings/password_setting.dart';
import 'package:trashify/pages/settings/profile_setting.dart';
import 'package:trashify/pages/settings/general_setting.dart';
import 'package:trashify/pages/settings/terms_condition.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<void> _keluarSesi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (context.mounted) {
      context.read<UserProvider>().resetUserData();
    }
    if (context.mounted) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/masuk', // Ganti dengan nama route yang sesuai
          (Route<dynamic> route) => route.settings.name == '/masuk',
        );
      }
    }
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Pengaturan',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/trashify.png',
                    width: 150,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildBagianPengaturan('Umum'),
                        _buildDaftarPengaturan(
                          icon: Icons.person_outline,
                          judul: 'Ubah Profil',
                          description:
                              'Ubah foto profil, nama, no. telp, dan lainnya',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileSetting()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.lock_outline,
                          judul: 'Ganti Kata Sandi',
                          description:
                              'Perbarui kata sandi untuk mengamankan akun anda',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordSetting()));
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildBagianPengaturan('Preferensi'),
                        _buildDaftarPengaturan(
                          icon: Icons.settings_outlined,
                          judul: 'Pengaturan Umum',
                          description: 'Atur berbagai fitur dari aplikasi',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GeneralSetting()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.info_outline,
                          judul: 'Syarat & Ketentuan',
                          description:
                              'Perjanjian hukum antara penyedia layanan dan pengguna',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SyaratKetentuan()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.exit_to_app,
                          judul: 'Keluar',
                          description: '',
                          color: const Color.fromARGB(255, 181, 61, 62),
                          rute: () => _keluarSesi(context),
                        ),
                        const SizedBox(height: 20),
                      ],
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

  Widget _buildBagianPengaturan(String bagian) {
    return Text(
      bagian,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildDaftarPengaturan({
    required IconData icon,
    required String judul,
    required String description,
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
        subtitle: description.isNotEmpty
            ? Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              )
            : null,
        onTap: rute,
      ),
    );
  }
}
