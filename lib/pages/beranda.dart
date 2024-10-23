import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/edukasi.dart';
import 'package:trashify/pages/edukasi/edukasi_video.dart';
import 'package:trashify/pages/informasi_pengangkutan.dart';
import 'package:trashify/pages/laporan.dart';
import 'package:trashify/pages/notifikasi.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Text(
          'Trashify',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifikasi()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 256,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/images/beranda_warga.png',
                ),
                fit: BoxFit.cover,
              )),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Pengguna!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '(slogan aplikasi)',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Text(
                      'Fitur',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardFitur(const Laporan(), Icons.report, 'Lapor', 'Laporkan terkait masalah sampah, TPS, dan kebersihan di sekitar Anda.'),
                  const SizedBox(width: 10),
                  _buildCardFitur(const InformasiPengangkutan(), Icons.calendar_month, 'Informasi', 'Lihat jadwal dan rute pengangkutan sampah di area Anda.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    Text(
                      'Edukasi',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Halaman Video Edukasi
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                          ),
                          child: Text(
                            'Video',
                            style: TextStyle(
                              fontSize: 14, color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Halaman Artikel Edukasi
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                          ),
                          child: Text(
                            'Artikel',
                            style: TextStyle(
                              fontSize: 14, color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Edukasi()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                          ),
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 12, color: Colors.black
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: SizedBox(
                        height: 250,
                        child: Container(
                          child: _buildCarouselEdukasi(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardFitur(Widget rute,IconData icon, String fitur, String deskripsi) {
    return Expanded(
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => rute),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 40, color: const Color.fromARGB(255, 59, 142, 110)),
                const SizedBox(height: 10),
                Text(
                  fitur,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselEdukasi() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: [
        _buildKontenEdukasi('Langkah Sederhana Memilah Sampah di Rumah',
            'assets/images/edukasi/contoh1.png', '1rb', '45',
            'https://youtu.be/tVuNnac7m0o?si=_V1jTyLC7QJvuDQO',
            'Salah satu solusi untuk menanggulangi masalah sampah adalah dengan memilah sampah dari sumbernya. Dengan memilah sampah, kita bisa mengurangi volume sampah yang berakhir di TPA, mempermudah proses daur ulang, dan mengetahui sampah-sampah apa saja yang masih memiliki nilai pakai mau pun nilai ekonomi.'),
        _buildKontenEdukasi('Karya Daur Ulang Sampah Plastik',
            'assets/images/edukasi/contoh2.png', '15rb', '56',
            'https://youtu.be/CGd3lgxReFE?si=-s4WpVT55tAW8OwM',
            'Mengajak tentang bagaimana pentingnya mengolah #sampah , dampak buruk seperti lingkungan dan kesehatan, serta bagaimana cara pengelolaan sampah yg benar yaitu dengan, CEGAH, PILAH, OLAH '),
      ],
    );
  }

  Widget _buildKontenEdukasi(
      String judul, String gambar, String suka, String komen, String videoUrl, String deskripsi) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EdukasiVideo(
                      videoUrl: videoUrl, judul: judul, deskripsi: deskripsi),
                ),
              );
            },
            child: SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        gambar, width: 270,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              judul,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.thumb_up, size: 16),
                const SizedBox(width: 4),
                Text(suka),
                const SizedBox(width: 16),
                const Icon(Icons.comment, size: 16),
                const SizedBox(width: 4),
                Text(komen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
