import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/edukasi/edukasi_artikel.dart';
import 'package:trashify/pages/edukasi/edukasi_video.dart';
import 'package:trashify/pages/edukasi/tambah_edukasi.dart';
import 'package:trashify/pages/notifikasi.dart';

class Edukasi extends StatefulWidget {
  const Edukasi({super.key});

  @override
  State<Edukasi> createState() => _EdukasiState();
}

class _EdukasiState extends State<Edukasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          widthFactor: 3.55,
          child: Text(
            'Edukasi',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahEdukasi()),
                          );
                        },
                        shape: const CircleBorder(),
                        backgroundColor:
                            const Color.fromARGB(255, 59, 142, 110),
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Like: 1,5 JT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Total Komentar: 900',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  hintStyle: TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildCarouselEdukasi(),
              const SizedBox(height: 20),
              Column(
                children: [
                  _buildEdukasiArtikel(
                      'artikel 1',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh1.png',
                      'Plastik, material serbaguna yang memudahkan kehidupan kita sehari-hari, ternyata menyimpan ancaman besar bagi lingkungan. Penggunaan plastik yang berlebihan dan pengelolaan sampah yang tidak tepat menyebabkan masalah serius seperti pencemaran laut, kerusakan ekosistem, dan perubahan iklim.'),
                  _buildEdukasiArtikel(
                      'artikel 2',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh2.png',
                      'Sampah organik seperti sisa makanan, kulit buah, dan daun-daun kering sebenarnya bukan sampah, melainkan potensi sumber daya yang berharga. Dengan membuat kompos, kita dapat mengubah sampah organik menjadi pupuk organik yang kaya nutrisi untuk tanaman.'),
                  _buildEdukasiArtikel(
                      'artikel 3',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh3.png',
                      'Mengatasi masalah sampah bukan hanya tanggung jawab pemerintah atau lembaga tertentu, tetapi juga tanggung jawab kita sebagai individu. Setiap tindakan kecil yang kita lakukan, seperti memilah sampah, mengurangi penggunaan plastik, dan mendaur ulang, akan berkontribusi pada lingkungan yang lebih bersih dan sehat.'),
                  _buildEdukasiArtikel(
                      'artikel 4',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh1.png',
                      'Plastik, material serbaguna yang memudahkan kehidupan kita sehari-hari, ternyata menyimpan ancaman besar bagi lingkungan. Penggunaan plastik yang berlebihan dan pengelolaan sampah yang tidak tepat menyebabkan masalah serius seperti pencemaran laut, kerusakan ekosistem, dan perubahan iklim.'),
                  _buildEdukasiArtikel(
                      'artikel 5',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh2.png',
                      'Sampah organik seperti sisa makanan, kulit buah, dan daun-daun kering sebenarnya bukan sampah, melainkan potensi sumber daya yang berharga. Dengan membuat kompos, kita dapat mengubah sampah organik menjadi pupuk organik yang kaya nutrisi untuk tanaman.'),
                  _buildEdukasiArtikel(
                      'artikel 6',
                      '109',
                      '23',
                      'assets/images/edukasi/contoh3.png',
                      'Mengatasi masalah sampah bukan hanya tanggung jawab pemerintah atau lembaga tertentu, tetapi juga tanggung jawab kita sebagai individu. Setiap tindakan kecil yang kita lakukan, seperti memilah sampah, mengurangi penggunaan plastik, dan mendaur ulang, akan berkontribusi pada lingkungan yang lebih bersih dan sehat.'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselEdukasi() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: false,
        enlargeCenterPage: true,
      ),
      items: [
        _buildEdukasiVideo(
            'assets/images/edukasi/contoh1.png',
            'https://youtu.be/tVuNnac7m0o?si=_V1jTyLC7QJvuDQO',
            'Pilah Sampah dari Rumah Yuk!',
            'Salah satu solusi untuk menanggulangi masalah sampah adalah dengan memilah sampah dari sumbernya. Dengan memilah sampah, kita bisa mengurangi volume sampah yang berakhir di TPA, mempermudah proses daur ulang, dan mengetahui sampah-sampah apa saja yang masih memiliki nilai pakai mau pun nilai ekonomi.'),
        _buildEdukasiVideo(
            'assets/images/edukasi/contoh2.png',
            'https://youtu.be/CGd3lgxReFE?si=-s4WpVT55tAW8OwM',
            'Sampahku Tanggung Jawabku',
            'Mengajak tentang bagaimana pentingnya mengolah #sampah , dampak buruk seperti lingkungan dan kesehatan, serta bagaimana cara pengelolaan sampah yg benar yaitu dengan, CEGAH, PILAH, OLAH '),
      ],
    );
  }

  Widget _buildEdukasiVideo(
      String gambar, String videoUrl, String judul, String deskripsi) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EdukasiVideo(
                    videoUrl: videoUrl, judul: judul, deskripsi: deskripsi),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    gambar,
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
        ));
  }

  Widget _buildEdukasiArtikel(String judul, String suka, String komentar,
      String gambar, String deskripsi) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EdukasiArtikel(
                      gambar: gambar, judul: judul, deskripsi: deskripsi),
                ),
              );
            },
            child: ListTile(
              title: Text(
                judul,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    suka,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.thumb_up, color: Colors.grey),
                  const SizedBox(width: 20),
                  Text(
                    komentar,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.comment, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
