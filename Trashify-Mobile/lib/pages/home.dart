import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/home/home_controller.dart';
import 'package:trashify/providers/user_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = HomeController();
  String selectedEducationType = 'Video';

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
    controller.fetchEducationContent(context, (loading) {
      if (mounted) {
        setState(() {
          controller.isLoading = loading;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).userName;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Text(
          'Trashify',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 256,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/beranda_warga.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $userName!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Satu Aplikasi, Banyak Solusi: Trashify untuk Lingkungan Bersih!',
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: controller.buildResponsiveCard(
                      context,
                      '/pengaduan',
                      'Icon_Pengaduan',
                      'Pengaduan',
                      'Adukan terkait masalah sampah, TPS, dan kebersihan di sekitar Anda.',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: controller.buildResponsiveCard(
                      context,
                      '/informasi_pengangkutan',
                      'Icon_Informasi',
                      'Pengangkutan',
                      'Lihat jadwal dan rute pengangkutan sampah di area Anda.',
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
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedEducationType =
                              'Video'; // Set jenis edukasi ke Video
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedEducationType == 'Video'
                            ? const Color.fromARGB(
                                255, 59, 142, 110) // Warna hijau
                            : Colors.white,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                      ),
                      child: Text(
                        'Video',
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedEducationType == 'Video'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedEducationType =
                              'Artikel'; // Set jenis edukasi ke Artikel
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedEducationType == 'Artikel'
                            ? const Color.fromARGB(
                                255, 59, 142, 110) // Warna hijau
                            : Colors.white,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                      ),
                      child: Text(
                        'Artikel',
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedEducationType == 'Artikel'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edukasi');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: Text(
                        'Lihat Semua',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selectedEducationType == 'Video') ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
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
                      height: 230,
                      child: Container(
                        child: controller.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 300,
                                      enableInfiniteScroll: true,
                                      enlargeCenterPage: true,
                                      viewportFraction: 0.8,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 15),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.easeInOut,
                                    ),
                                    items: controller.educationContent
                                            ?.where((item) =>
                                                item['Jenis_Edukasi'] ==
                                                'Video') // Filter for Video
                                            .map<Widget>((item) {
                                          String videoId;
                                          String youtubeUrl = item['Link_URL'];

                                          if (youtubeUrl.contains('v=')) {
                                            videoId = youtubeUrl
                                                    .split('v=')[1]
                                                    .split('&')[
                                                0]; // Mengambil ID video
                                          } else if (youtubeUrl
                                              .contains('youtu.be/')) {
                                            videoId = youtubeUrl
                                                    .split('youtu.be/')[1]
                                                    .split('?')[
                                                0]; // Mengambil ID video dari short link
                                          } else {
                                            videoId =
                                                ''; // ID video tidak ditemukan
                                          }

                                          String thumbnailUrl = videoId
                                                  .isNotEmpty
                                              ? 'https://img.youtube.com/vi/$videoId/0.jpg'
                                              : ''; // URL thumbnail

                                          return Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (videoId.isNotEmpty) {
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/konten_edukasi',
                                                        arguments: {
                                                          'educationId': item[
                                                              'ID_Edukasi'],
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: videoId.isNotEmpty
                                                          ? Image.network(
                                                              thumbnailUrl,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Container(
                                                                  color: Colors
                                                                      .grey,
                                                                  child: const Center(
                                                                      child: Text(
                                                                          'Thumbnail tidak tersedia')),
                                                                );
                                                              },
                                                            )
                                                          : Container(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item['Judul_Edukasi'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList() ??
                                        [],
                                  ),
                                  Positioned(
                                    left: 16,
                                    child: Icon(Icons.arrow_back,
                                        color: Colors.black),
                                  ),
                                  Positioned(
                                    right: 16,
                                    child: Icon(Icons.arrow_forward,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              )
            ] else if (selectedEducationType == 'Artikel') ...[
              Card(
                color: Colors.white,
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.educationContent
                          ?.where((item) => item['Jenis_Edukasi'] == 'Artikel')
                          .length ??
                      0, // Filter for Artikel
                  itemBuilder: (context, index) {
                    final item = controller.educationContent!
                        .where((item) => item['Jenis_Edukasi'] == 'Artikel')
                        .toList()[index]; // Get filtered Artikel
                    return Card(
                      elevation: 3,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(item['Judul_Edukasi']),
                        subtitle: Text(
                          item['Deskripsi_Edukasi'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/konten_edukasi',
                            arguments: {
                              'educationId': item['ID_Edukasi'],
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
