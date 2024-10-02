import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashify/pages/auth/login.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  // Fungsi untuk keluar/log out
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
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
            Navigator.pop(context); // Kembali ke halaman sebelumnya
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
            // Bagian Pengaturan Umum
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
                        // Aksi untuk ubah profil
                      },
                    ),
                    _buildSettingItem(
                      icon: Icons.lock_outline,
                      title: 'Ganti Kata Sandi',
                      subtitle:
                          'Perbarui kata sandi untuk mengamankan akun anda',
                      onTap: () {
                        // Aksi untuk ganti kata sandi
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSettingSection('Preferensi'),
                    _buildSettingItem(
                      icon: Icons.notifications_outlined,
                      title: 'Pengaturan Notifikasi',
                      subtitle: 'Atur berbagai notifikasi dari aplikasi',
                      onTap: () {
                        // Aksi untuk pengaturan notifikasi
                      },
                    ),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      title: 'Syarat dan Ketentuan',
                      subtitle:
                          'Perjanjian hukum antara penyedia layanan dan pengguna',
                      onTap: () {
                        // Aksi untuk melihat syarat dan ketentuan
                      },
                    ),
                    const SizedBox(height: 20),
                    // Tombol Keluar
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

  // Fungsi untuk membuat section title (contoh: Umum, Preferensi)
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

  // Fungsi untuk membuat item pengaturan
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
