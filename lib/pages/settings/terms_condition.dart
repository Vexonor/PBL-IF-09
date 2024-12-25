import 'package:flutter/material.dart';

class SyaratKetentuan extends StatefulWidget {
  const SyaratKetentuan({super.key});

  @override
  State<SyaratKetentuan> createState() => _SyaratKetentuanState();
}

class _SyaratKetentuanState extends State<SyaratKetentuan> {
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
                    'Syarat & Ketentuan',
                    style: TextStyle(
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
                            '1. Penerimaan Syarat dan Ketentuan Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi syarat dan ketentuan yang ditetapkan. Jika Anda tidak setuju, mohon untuk tidak menggunakan aplikasi ini.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            '2. Pendaftaran Akun Pengguna diwajibkan untuk mendaftar dan membuat akun untuk dapat mengakses fitur aplikasi. Pengguna bertanggung jawab untuk menjaga kerahasiaan informasi akun dan password.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            '3. Penggunaan Aplikasi Aplikasi ini hanya boleh digunakan untuk tujuan pelaporan dan pengelolaan sampah yang berkaitan dengan lingkungan. Pengguna dilarang melakukan tindakan yang dapat merugikan pihak lain atau menciptakan konten yang melanggar hukum.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
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
}
