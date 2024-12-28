import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trashify/controllers/education/education_content_detail_controller.dart';

class EducationContentDetail extends StatefulWidget {
  const EducationContentDetail({super.key});

  @override
  State<EducationContentDetail> createState() => _EducationContentDetailState();
}

class _EducationContentDetailState extends State<EducationContentDetail> {
  final EducationContentDetailController controller =
      EducationContentDetailController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final educationId = args['educationId'];

      controller.fetchEducationAndComments(context, educationId, (loading) {
        if (mounted) {
          setState(() {
            controller.isLoading = loading;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Memformat tanggal dari string ke format yang diinginkan
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
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
          '/galeri_konten_edukasi',
          (Route<dynamic> route) =>
              route.isFirst || route.settings.name == '/edukasi',
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
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/galeri_konten_edukasi',
                  (Route<dynamic> route) =>
                      route.isFirst || route.settings.name == '/edukasi',
                );
              }
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Detail Konten Edukasi',
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
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle('Judul Konten Edukasi'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.educationContent != null
                        ? controller.educationContent!['Judul_Edukasi']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    _buildTitle('Deskripsi Konten Edukasi'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.educationContent != null
                        ? controller.educationContent!['Deskripsi_Edukasi']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    _buildTitle('Jenis Konten Edukasi'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.educationContent != null
                        ? controller.educationContent!['Jenis_Edukasi']
                        : 'Memuat...'),
                    controller.educationContent != null &&
                            controller.educationContent!['Jenis_Edukasi'] ==
                                'Video'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              _buildTitle('Link URL'),
                              const SizedBox(height: 8),
                              _buildYoutubeThumbnail(
                                  controller.educationContent!['Link_URL'] ??
                                      'Memuat...'),
                              const SizedBox(height: 8),
                              _buildDescription(
                                  controller.educationContent!['Link_URL'] ??
                                      'Memuat...'),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const SizedBox(height: 16),
                    _buildTitle('Status Konten Edukasi'),
                    const SizedBox(height: 8),
                    _buildDescription((controller.educationContent != null &&
                            controller.educationContent!['Status_Edukasi'] !=
                                null)
                        ? controller.educationContent!['Status_Edukasi']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Tanggal Dibuat'),
                            const SizedBox(height: 8),
                            _buildDescriptionDate(controller.educationContent !=
                                    null
                                ? formatDate(
                                    controller.educationContent!['created_at'])
                                : 'Memuat...'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Tanggal Diperbarui'),
                            const SizedBox(height: 8),
                            _buildDescriptionDate(controller.educationContent !=
                                    null
                                ? formatDate(
                                    controller.educationContent!['updated_at'])
                                : 'Memuat...'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (controller
                                    .educationContent!['Status_Edukasi'] ==
                                'Draf') {
                              controller.showSnackBar(
                                  context,
                                  'Konten Edukasi masih Draf, Silakan tunggu admin untuk mengkonfirmasi edukasi.',
                                  const Color.fromARGB(255, 58, 103, 134),
                                  2000);
                            } else {
                              Navigator.pushNamed(
                                context,
                                '/konten_edukasi',
                                arguments: {
                                  'educationId': controller
                                      .educationContent!['ID_Edukasi'],
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.view_agenda,
                              color: Colors.white),
                          label: Text(
                            'Lihat',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 142, 110),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit_konten_edukasi',
                              arguments: {
                                'educationId':
                                    controller.educationContent!['ID_Edukasi'],
                              },
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: Text('Edit',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 58, 103, 134),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            controller.showDeleteConfirmationDialog(context);
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: Text('Hapus',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 181, 61, 62),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // Membangun judul untuk bagian konten
  Widget _buildTitle(String judul) {
    return Text(
      judul,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Membangun deskripsi untuk bagian konten
  Widget _buildDescription(String isi) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isi,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  // Membangun deskripsi tanggal untuk bagian konten
  Widget _buildDescriptionDate(String isi) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isi,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  // Membangun thumbnail YouTube berdasarkan URL
  Widget _buildYoutubeThumbnail(String? url) {
    String videoId = '';
    String youtubeUrl = url ?? '';

    if (youtubeUrl.isNotEmpty) {
      if (youtubeUrl.contains('v=')) {
        videoId = youtubeUrl.split('v=')[1].split('&')[0];
      } else if (youtubeUrl.contains('youtu.be/')) {
        videoId = youtubeUrl.split('youtu.be/')[1].split('?')[0];
      } else if (youtubeUrl.contains('embed/')) {
        videoId = youtubeUrl.split('embed/')[1].split('?')[0];
      } else if (youtubeUrl.contains('/v/')) {
        videoId = youtubeUrl.split('/v/')[1].split('?')[0];
      }
    }

    String thumbnailUrl =
        videoId.isNotEmpty ? 'https://img.youtube.com/vi/$videoId/0.jpg' : '';

    return thumbnailUrl.isNotEmpty
        ? Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black54,
                  child: Text(
                    'Preview Thumbnail',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
