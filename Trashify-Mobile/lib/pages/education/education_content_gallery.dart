import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/education/education_content_galery_controller.dart';
import 'package:trashify/providers/user_provider.dart';

class EducationContentGallery extends StatefulWidget {
  const EducationContentGallery({super.key});

  @override
  State<EducationContentGallery> createState() =>
      _EducationContentGalleryState();
}

class _EducationContentGalleryState extends State<EducationContentGallery> {
  final EducationContentGaleryController controller =
      EducationContentGaleryController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
    final userId = Provider.of<UserProvider>(context).userId;

    controller.fetchEducationContentGalery(context, userId!, (loading) {
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
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/edukasi',
            (Route<dynamic> route) => route.isFirst,
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 59, 142, 110),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/edukasi',
                  (Route<dynamic> route) => route.isFirst,
                );
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Galeri Edukasi Saya',
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
          body: controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }
                            return controller.suggestions
                                .where((String option) {
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (String selection) {
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
                                setState(() {
                                  controller.searchQuery = value;
                                });
                              },
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            double maxHeight =
                                MediaQuery.of(context).size.height * 0.25;
                            double itemHeight = 56.0;
                            double dynamicHeight = options.length * itemHeight;
                            double height = dynamicHeight > maxHeight
                                ? maxHeight
                                : dynamicHeight;

                            return Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: height,
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
                      Expanded(
                        child: controller.educationContent == null ||
                                controller.educationContent!.isEmpty
                            ? Center(
                                child: Text(
                                  'Belum ada Konten Edukasi yang dibuat',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.educationContent
                                        ?.where((item) => item['Judul_Edukasi']
                                            .toLowerCase()
                                            .contains(controller.searchQuery
                                                .toLowerCase()))
                                        .length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final item = controller.educationContent!
                                      .where((item) => item['Judul_Edukasi']
                                          .toLowerCase()
                                          .contains(controller.searchQuery
                                              .toLowerCase()))
                                      .toList()[index];
                                  String videoId;
                                  String youtubeUrl = item['Link_URL'] ?? '';

                                  if (youtubeUrl.isNotEmpty) {
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
                                  } else {
                                    videoId = '';
                                  }

                                  String thumbnailUrl = videoId.isNotEmpty
                                      ? 'https://img.youtube.com/vi/$videoId/0.jpg'
                                      : '';
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/detail_konten_edukasi',
                                        arguments: {
                                          'educationId': item['ID_Edukasi'],
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 5,
                                        child: ListTile(
                                          leading: item['Jenis_Edukasi'] ==
                                                  'Video'
                                              ? AspectRatio(
                                                  aspectRatio: 16 / 9,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      thumbnailUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              : null,
                                          title: Text(
                                            item['Judul_Edukasi'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            item['Deskripsi_Edukasi'] ??
                                                "Deskripsi tidak tersedia",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing:
                                              item['Jenis_Edukasi'] == 'Artikel'
                                                  ? Icon(Icons.article)
                                                  : Icon(Icons.play_arrow),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tambah_konten_edukasi');
            },
            backgroundColor: const Color.fromARGB(
                255, 59, 142, 110), // Warna latar belakang tombol
            shape: const CircleBorder(), // Bentuk tombol
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  const Icon(Icons.add, color: Colors.white), // Ikon tombol
                  Text(
                    'Tambah Edukasi', // Teks tombol
                    style: TextStyle(
                      fontSize: 6,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
