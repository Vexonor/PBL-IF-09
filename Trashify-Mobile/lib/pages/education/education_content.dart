import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/education/education_content_controller.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/services/global_url.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationContent extends StatefulWidget {
  const EducationContent({super.key});

  @override
  State<EducationContent> createState() => _EducationContentState();
}

class _EducationContentState extends State<EducationContent> {
  final EducationContentController controller = EducationContentController();
  YoutubePlayerController? _youtubeController;

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
            if (controller.educationContent != null) {
              String? videoUrl = controller.educationContent!['Link_URL'];
              if (videoUrl != null) {
                String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
                _youtubeController = YoutubePlayerController(
                  initialVideoId: videoId ?? "",
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );
              }
            }
          });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        _youtubeController?.pause();
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/edukasi', // Ganti dengan nama route yang sesuai
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
              _youtubeController?.pause();
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
                  'Konten Edukasi',
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.educationContent != null &&
                          controller.educationContent!['Jenis_Edukasi'] ==
                              'Video') ...[
                        YoutubePlayer(
                          controller: _youtubeController!,
                          showVideoProgressIndicator: true,
                          onReady: () {
                            _youtubeController!.addListener(() {});
                          },
                        ),
                      ],
                      Text(
                        controller.educationContent != null
                            ? '${controller.educationContent!['Judul_Edukasi']}'
                            : 'Memuat...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (controller.educationContent != null) ...[
                        if (controller.educationContent!['Jenis_Edukasi'] ==
                            'Video') ...[
                          if (controller.descriptionVisible) ...[
                            SizedBox(height: 10),
                            Text(
                              controller.name != null
                                  ? 'Diunggah oleh: ${controller.name}'
                                  : 'Memuat...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${controller.educationContent!['Deskripsi_Edukasi']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${controller.totalComments} Komentar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          TextButton(
                            onPressed: () {
                              setState(() {
                                controller.descriptionVisible =
                                    !controller.descriptionVisible;
                              });
                            },
                            child: Text(
                              controller.descriptionVisible
                                  ? 'Sembunyikan'
                                  : 'Selengkapnya',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 58, 103, 134),
                              ),
                            ),
                          ),
                        ] else ...[
                          SizedBox(height: 10),
                          Text(
                            controller.name != null
                                ? 'Diunggah oleh: ${controller.name}'
                                : 'Memuat...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${controller.educationContent!['Deskripsi_Edukasi']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${controller.totalComments} Komentar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                      const SizedBox(height: 10),
                      Divider(thickness: 1, color: Colors.grey[300]),
                      const SizedBox(height: 10),
                      if (!controller.commentsVisible)
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                controller.commentsVisible =
                                    !controller.commentsVisible;
                                if (!controller.commentsVisible) {
                                  controller.currentPage = 0;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 142, 110),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              'Lihat Komentar',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (controller.commentsVisible) ...[
                        Form(
                          key: controller.formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: controller.commentController,
                                      enabled: !controller.isProcessing,
                                      minLines: 1,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText:
                                            'Ketikkan komentar anda disini',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        errorMaxLines: 2,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Komentar tidak boleh kosong';
                                        } else if (value.length > 255) {
                                          return 'Komentar tidak boleh lebih dari 255 karakter';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          controller.commentIndicator = value;
                                          if (controller
                                                  .commentIndicator.length >
                                              controller.maxCharacters) {
                                            controller.textColor =
                                                const Color.fromARGB(
                                                    255, 181, 61, 62);
                                            controller.indicatorColor =
                                                const Color.fromARGB(
                                                    255, 181, 61, 62);
                                          } else {
                                            controller.textColor = Colors.black;
                                            controller.indicatorColor =
                                                Colors.grey;
                                          }
                                        });
                                      },
                                      onFieldSubmitted: (value) {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.submitComment(context);
                                        }
                                      },
                                      style: TextStyle(
                                          color: controller.textColor),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              Column(
                                children: [
                                  Text(
                                    '${controller.maxCharacters - controller.commentIndicator.length}',
                                    style: TextStyle(
                                        color: controller.indicatorColor),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: controller.isProcessing
                                        ? null
                                        : () {
                                            setState(() {
                                              controller.submitComment(context);
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 59, 142, 110),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                    ),
                                    child: controller.isProcessing
                                        ? SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.send,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        const SizedBox(height: 10),
                        if (controller.comment.isEmpty) ...[
                          Center(
                            child: Text(
                              'Belum ada komentar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 10)
                        ] else ...[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: (controller.currentPage + 1) *
                                        controller.commentsPerPage >
                                    controller.totalComments
                                ? controller.totalComments -
                                    (controller.currentPage *
                                        controller.commentsPerPage)
                                : controller.commentsPerPage,
                            itemBuilder: (context, index) {
                              int commentIndex = controller.currentPage *
                                      controller.commentsPerPage +
                                  index;
                              int commentUserId = controller
                                      .comment[commentIndex]['ID_User'] ??
                                  '';
                              String commentText = controller
                                      .comment[commentIndex]['Isi_Komentar'] ??
                                  'Komentar tidak tersedia';
                              String userName = controller.comment[commentIndex]
                                      ['user_table']['Nama'] ??
                                  'Anonim'; // Ambil nama pengguna dari user_table
                              String userProfilePhoto =
                                  controller.comment[commentIndex]['user_table']
                                          ['Foto_Profil'] ??
                                      ''; // Ambil foto profil dari user_table

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      // Tampilkan foto profil
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color.fromARGB(
                                            255, 59, 142, 110),
                                        backgroundImage:
                                            userProfilePhoto.isNotEmpty
                                                ? NetworkImage(
                                                '$imageStorageUrl/$userProfilePhoto')
                                                : null,
                                        child: userProfilePhoto.isEmpty
                                            ? Icon(
                                                Icons.person,
                                                size: 20,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Tampilkan nama pengguna
                                            Text(
                                              userName,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            // Tampilkan komentar
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey[200],
                                              ),
                                              child: Text(
                                                commentText,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (commentUserId == userId) ...[
                                        IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {
                                            controller
                                                .showDeleteConfirmationDialog(
                                                    context,
                                                    controller.comment[index]
                                                        ['ID_Komentar']);
                                          },
                                        ),
                                      ]
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: controller.currentPage > 0
                                    ? () {
                                        setState(() {
                                          controller.currentPage--;
                                        });
                                      }
                                    : null,
                                child: Icon(Icons.arrow_back),
                              ),
                              ElevatedButton(
                                onPressed: (controller.currentPage + 1) *
                                            controller.commentsPerPage <
                                        controller.totalComments
                                    ? () {
                                        setState(() {
                                          controller.currentPage++;
                                        });
                                      }
                                    : null,
                                child: Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ],
                      ],
                      if (controller.commentsVisible)
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                controller.commentsVisible =
                                    !controller.commentsVisible;
                                if (!controller.commentsVisible) {
                                  controller.currentPage = 0;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 142, 110),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              'Sembunyikan Komentar',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
