import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/comment_service.dart';
import 'package:trashify/services/education_service.dart';

class EducationContentController {
  final CommentService commentService = CommentService();
  final EducationService educationService = EducationService();
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final int maxCharacters = 255;

  bool commentsVisible = false;
  bool descriptionVisible = false;
  bool isLoading = false;
  bool isProcessing = false;
  Color indicatorColor = Colors.grey;
  Color textColor = Colors.black;
  int? userId;
  int commentsPerPage = 3;
  int currentPage = 0;
  int totalComments = 0;
  List<dynamic> comment = [];
  Map<String, dynamic>? educationContent;
  String commentIndicator = '';
  String? name;

  EducationContentController() {
    init();
  }

  // Menginisialisasi controller dan mendapatkan ID pengguna saat ini
  Future<void> init() async {
    await _getCurrentUserId();
  }

  // Mengambil ID pengguna saat ini dari SharedPreferences
  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  // Mengambil data konten edukasi dan komentar berdasarkan educationId
  Future<void> fetchEducationAndComments(
      BuildContext context, int educationId, Function(bool) setLoading) async {
    setLoading(true);
    try {
      final responseContent =
          await educationService.showEducationContent(educationId);
      if (responseContent.statusCode == 200) {
        final data = json.decode(responseContent.body);
        educationContent = data['konten'];
        name = data['nama'];
        commentsPerPage = educationContent!['Jenis_Edukasi'] == 'Video' ? 3 : 6;
      } else {
        if (context.mounted) {
          final data = json.decode(responseContent.body);
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
        return;
      }

      final responseComment = await commentService.showComment(educationId);
      if (responseComment.statusCode == 200) {
        comment = json.decode(responseComment.body);
        comment.sort((a, b) => DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at'])));
        totalComments = comment.length;
      } else {
        if (context.mounted) {
          final data = json.decode(responseComment.body);
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
        return;
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false);
    }
  }

  // Mengirim komentar baru
  Future<void> submitComment(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;
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
        }
      } finally {
        isProcessing = false;
      }
    }
  }

  // Menghapus komentar berdasarkan index
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
    } else if (response.statusCode == 403 || response.statusCode == 404) {
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

  // Menampilkan dialog konfirmasi untuk menghapus komentar
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
              onPressed: isProcessing
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: isProcessing
                  ? null
                  : () async {
                      await deleteComment(context, commentId);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
              child: Text('Hapus',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 181, 61, 62),
                      fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Menampilkan snackbar dengan pesan
  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Positioned(
          bottom: 10.0 + keyboardHeight,
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
                child: Text(message, style: TextStyle(color: Colors.white)),
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
