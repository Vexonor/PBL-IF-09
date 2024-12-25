import 'package:trashify/controllers/education/education_controller.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final EducationController controller =
      EducationController(); // Create an instance of your controller

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
      controller.suggestions = controller.educationContent
              ?.map((item) => item['Judul_Edukasi'] as String)
              .toList() ??
          [];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Edukasi',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.video_library, // Ganti ikon notifikasi dengan ikon video
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context,
                  '/galeri_konten_edukasi'); // Ganti dengan named route
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          Navigator.pushNamed(
                            context,
                            '/tambah_konten_edukasi',
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
                            'Konten Edukasi Saya: ${controller.allContent?.where((item) => item['ID_User'] == userId).length ?? 0}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Komentar Konten Saya: ${controller.comment?.where((item) => controller.allContent?.any((edu) => edu['ID_User'] == userId && edu['ID_Edukasi'] == item['ID_Edukasi']) ?? false).length ?? 0}',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return controller.suggestions.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    // Simpan saran yang dipilih
                    setState(() {
                      controller.searchQuery = selection;
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      enabled: !controller.isLoading,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: TextStyle(fontSize: 14),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        // Update searchQuery setiap kali teks berubah
                        setState(() {
                          controller.searchQuery =
                              value; // Update variabel pencarian
                        });
                      },
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    // Hitung tinggi maksimum (1/4 layar)
                    double maxHeight =
                        MediaQuery.of(context).size.height * 0.25;

                    // Hitung tinggi berdasarkan jumlah item
                    double itemHeight = 56.0; // Tinggi setiap item ListTile
                    double dynamicHeight = options.length * itemHeight;

                    // Batasi tinggi maksimum
                    double height =
                        dynamicHeight > maxHeight ? maxHeight : dynamicHeight;

                    return Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: height, // Gunakan tinggi dinamis
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 4.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                title: Text(option),
                                onTap: () {
                                  onSelected(option);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Edukasi Video',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Bagian dalam Widget build
              Padding(
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
                                            item['Jenis_Edukasi'] == 'Video' &&
                                            item['Judul_Edukasi']
                                                .toLowerCase()
                                                .contains(controller.searchQuery
                                                    .toLowerCase())) // Filter berdasarkan pencarian
                                        .map<Widget>((item) {
                                      String videoId;
                                      String youtubeUrl = item['Link_URL'];

                                      // Cek apakah URL mengandung 'v='
                                      if (youtubeUrl.contains('v=')) {
                                        videoId = youtubeUrl
                                            .split('v=')[1]
                                            .split('&')[0];
                                      } else if (youtubeUrl
                                          .contains('youtu.be/')) {
                                        videoId = youtubeUrl
                                            .split('youtu.be/')[1]
                                            .split('?')[0];
                                      } else {
                                        videoId = '';
                                      }

                                      String thumbnailUrl = videoId.isNotEmpty
                                          ? 'https://img.youtube.com/vi/$videoId/0.jpg'
                                          : '';

                                      return Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
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
                                                      'educationId':
                                                          item['ID_Edukasi'],
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
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Container(
                                                              color:
                                                                  Colors.grey,
                                                              child: const Center(
                                                                  child: Text(
                                                                      'Thumbnail tidak tersedia')),
                                                            );
                                                          },
                                                        )
                                                      : Container(
                                                          color: Colors.grey),
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                              ),
                              // Menampilkan pesan jika tidak ada video ditemukan
                              if (controller.educationContent
                                      ?.where((item) =>
                                          item['Jenis_Edukasi'] == 'Video' &&
                                          item['Judul_Edukasi']
                                              .toLowerCase()
                                              .contains(controller.searchQuery
                                                  .toLowerCase()))
                                      .isEmpty ??
                                  true)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Tidak ada Video Edukasi yang sesuai',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 181, 61, 62),
                                    ),
                                  ),
                                ),
                              // Panah Navigasi Kiri
                              Positioned(
                                left: 16,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                              // Panah Navigasi Kanan
                              Positioned(
                                right: 16,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: controller.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Text(
                              'Edukasi Artikel',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            // Filtered ListView
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.educationContent
                                      ?.where((item) =>
                                          item['Jenis_Edukasi'] == 'Artikel' &&
                                          item['Judul_Edukasi']
                                              .toLowerCase()
                                              .contains(controller.searchQuery
                                                  .toLowerCase()))
                                      .length ??
                                  0,
                              itemBuilder: (context, index) {
                                final item = controller.educationContent!
                                    .where((item) =>
                                        item['Jenis_Edukasi'] == 'Artikel' &&
                                        item['Judul_Edukasi']
                                            .toLowerCase()
                                            .contains(controller.searchQuery
                                                .toLowerCase()))
                                    .toList()[index];
                                return Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: ListTile(
                                    title: Text(
                                      item['Judul_Edukasi'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                            // Tampilkan pesan jika tidak ada edukasi ditemukan
                            if (controller.educationContent
                                    ?.where((item) =>
                                        item['Jenis_Edukasi'] == 'Artikel' &&
                                        item['Judul_Edukasi']
                                            .toLowerCase()
                                            .contains(controller.searchQuery
                                                .toLowerCase()))
                                    .isEmpty ??
                                true)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Tidak ada Artikel Edukasi yang sesuai',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 181, 61, 62),
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
