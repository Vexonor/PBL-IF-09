import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/auth/masuk.dart';
import 'package:trashify/pages/pengaturan/pengaturan_kata_sandi.dart';
import 'package:trashify/pages/pengaturan/pengaturan_profil.dart';
import 'package:trashify/pages/pengaturan/pengaturan_notifikasi.dart';
import 'package:trashify/pages/pengaturan/syarat_ketentuan.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
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
                    'Pengaturan',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
                          title: 'Ubah Profil',
                          subtitle:
                              'Ubah foto profil, nama, no. telp, dan lainnya',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PengaturanProfil()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.lock_outline,
                          title: 'Ganti Kata Sandi',
                          subtitle:
                              'Perbarui kata sandi untuk mengamankan akun anda',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PengaturanKataSandi()));
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
                          icon: Icons.notifications_outlined,
                          title: 'Pengaturan Notifikasi',
                          subtitle: 'Atur berbagai notifikasi dari aplikasi',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PengaturanNotifikasi()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.info_outline,
                          title: 'Syarat & Ketentuan',
                          subtitle:
                              'Perjanjian hukum antara penyedia layanan dan pengguna',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SyaratKetentuan()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.exit_to_app,
                          title: 'Keluar',
                          subtitle: '',
                          color: Colors.redAccent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Masuk()));
                          },
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

  Widget _buildBagianPengaturan(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildDaftarPengaturan({
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
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
