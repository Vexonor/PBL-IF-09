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
        title: Center(
          widthFactor: 2.4,
          child: Text(
            'Pengaturan',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
                          deskripsi:
                              'Ubah foto profil, nama, no. telp, dan lainnya',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PengaturanProfil()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.lock_outline,
                          judul: 'Ganti Kata Sandi',
                          deskripsi:
                              'Perbarui kata sandi untuk mengamankan akun anda',
                          rute: () {
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
                          judul: 'Pengaturan Notifikasi',
                          deskripsi: 'Atur berbagai notifikasi dari aplikasi',
                          rute: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PengaturanNotifikasi()));
                          },
                        ),
                        _buildDaftarPengaturan(
                          icon: Icons.info_outline,
                          judul: 'Syarat & Ketentuan',
                          deskripsi:
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
                          deskripsi: '',
                          color: Colors.redAccent,
                          rute: () {
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
    required String deskripsi,
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
        subtitle: deskripsi.isNotEmpty
            ? Text(
                deskripsi,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              )
            : null,
        onTap: rute,
      ),
    );
  }
}
