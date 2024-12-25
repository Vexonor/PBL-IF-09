import 'dart:convert'; // For JSON conversion
import 'package:trashify/services/comment_service.dart';
import 'package:flutter/material.dart'; // For Flutter widgets
import 'package:trashify/services/education_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Service to manage educational content

// Kelas EducationController bertanggung jawab untuk mengelola konten edukasi
class EducationContentController {
  final EducationService educationService =
      EducationService(); // Inisialisasi layanan edukasi
  final CommentService commentService =
      CommentService(); // Inisialisasi layanan edukasi
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final int maxCharacters = 255;
  Map<String, dynamic>? educationContent; // Menyimpan konten edukasi
  List<dynamic> comment = []; // Menyimpan comment
  bool isLoading = false; // Menandakan apakah data sedang dimuat
  bool isProcessing = false;
  int? userId;
  int currentPage = 0;
  int totalComments = 0; // Total komentar
  int commentsPerPage = 3; // Jumlah komentar per halaman
  bool commentsVisible = false;
  bool descriptionVisible = false;
  String commentIndicator = '';
  String? name;
  Color textColor = Colors.black;
  Color indicatorColor = Colors.grey;

  // Mengambil data konten edukasi berdasarkan educationId
  Future<void> fetchEducationAndComments(
      BuildContext context, int educationId, Function(bool) setLoading) async {
    setLoading(true); // Start loading

    try {
      // Fetch konten edukasi
      final responseContent =
          await educationService.showEducationContent(educationId);
      if (responseContent.statusCode == 200) {
        final data = json.decode(responseContent.body);
        // Misalkan Anda ingin menyimpan data ini ke dalam variabel
        educationContent = data['konten'];
        name = data['nama'];
        commentsPerPage = educationContent!['Jenis_Edukasi'] == 'Video' ? 3 : 6;
      } else {
        // Tangani error untuk konten edukasi
        if (context.mounted) {
          final data = json.decode(responseContent.body);
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
        return; // Keluar jika ada error
      }

      // Fetch komentar
      final responseComment = await commentService.showComment(educationId);
      if (responseComment.statusCode == 200) {
        comment = json.decode(responseComment.body);
        comment.sort((a, b) => DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at'])));
        totalComments = comment.length;
      } else {
        // Tangani error untuk komentar
        if (context.mounted) {
          final data = json.decode(responseComment.body);
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
        return; // Keluar jika ada error
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false); // Stop loading
    }
  }

  EducationContentController() {
    init();
  }

  Future<void> init() async {
    await _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  Future<void> submitComment(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;

      // Mengirim pengaduan
      final response = await commentService.storeComment(
        educationContent!['ID_Edukasi'].toString(),
        userId!.toString(),
        commentController.text,
      );

      try {
        if (response.statusCode == 201) {
          final data = json.decode(response.body);
          commentIndicator = '';
          commentController.clear();
          commentsVisible = true;
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 2000);
            await fetchEducationAndComments(
                context, educationContent!['ID_Edukasi'], (loading) {
              isLoading = loading;
            });
            (context as Element).markNeedsBuild();
          }
        } else if (response.statusCode == 500) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
            (context as Element).markNeedsBuild();
          }
        } else {
          if (context.mounted) {
            showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62), 2000);
            (context as Element).markNeedsBuild();
          }
        }
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
          (context as Element).markNeedsBuild();
        } // Menangani pengecualian
      } finally {
        isProcessing = false; // Set loading menjadi false
      }
    }
  }

  Future<void> deleteComment(BuildContext context, int index) async {
    final response = await commentService.destroyComment(index);
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (context.mounted) {
        showSnackBar(
            context, data['message'], Color.fromARGB(255, 59, 142, 110), 2000);
        await fetchEducationAndComments(
            context, educationContent!['ID_Edukasi'], (loading) {
          isLoading = loading;
        });
        (context as Element).markNeedsBuild();
      }
    } else if (response.statusCode == 403) {
      final data = json.decode(response.body);
      if (context.mounted) {
        showSnackBar(context, data['message'],
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani error
    } else if (response.statusCode == 404) {
      final data = json.decode(response.body);
      if (context.mounted) {
        showSnackBar(context, data['message'],
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani error
    } else {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani error
    }
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, int commentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Komentar'),
          content: Text('Apakah Anda yakin ingin menghapus komentar ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: isProcessing
                  ? null
                  : () async {
                      await deleteComment(context,
                          commentId); // Panggil fungsi untuk menghapus komentar
                      // Logika untuk menghapus komentar
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Tutup dialog
                      }
                    },
              child: Text(
                'Hapus',
                style: TextStyle(
                    color: const Color.fromARGB(255, 181, 61, 62),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        // Mendapatkan tinggi keyboard
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 10.0 +
              keyboardHeight, // Jarak dari bawah ditambah tinggi keyboard
          left: 0,
          right: 0,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(milliseconds: time), () {
      overlayEntry.remove();
    });
  }
}
