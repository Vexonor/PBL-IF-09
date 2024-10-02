import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashify/pages/auth/login.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LogIn()
    ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 133, 102),
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
          'Pengaturan',
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/trashify.png',
                    width: 150,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    _buildSettingSection('Umum'),
                    _buildSettingItem(
                      icon: Icons.person_outline,
                      title: 'Ubah Profil',
                      subtitle: 'Ubah foto profil, nama, no. telp, dan lainnya',
                      onTap: () {
                        // TODO: Halaman Ubah Profil
                      },
                    ),
                    _buildSettingItem(
                      icon: Icons.lock_outline,
                      title: 'Ganti Kata Sandi',
                      subtitle:
                          'Perbarui kata sandi untuk mengamankan akun anda',
                      onTap: () {
                        // TODO: Halaman Ganti Kata Sandi
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingSection('Preferensi'),
                    _buildSettingItem(
                      icon: Icons.notifications_outlined,
                      title: 'Pengaturan Notifikasi',
                      subtitle: 'Atur berbagai notifikasi dari aplikasi',
                      onTap: () {
                        // TODO: Halaman Notifikasi
                      },
                    ),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      title: 'Syarat dan Ketentuan',
                      subtitle:
                          'Perjanjian hukum antara penyedia layanan dan pengguna',
                      onTap: () {
                        // TODO: Halaman Syarat dan Ketentuan
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingItem(
                      icon: Icons.exit_to_app,
                      title: 'Keluar',
                      subtitle: '',
                      color: Colors.redAccent,
                      onTap: () => _logout(context),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
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
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: GoogleFonts.poppins(
                    fontSize: 14, 
                    color: Colors.black54
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
