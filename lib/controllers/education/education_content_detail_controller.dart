import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/comment_service.dart';
import 'package:trashify/services/education_service.dart';

class EducationContentDetailController {
  final CommentService commentService = CommentService();
  final EducationService educationService = EducationService();

  bool isLoading = false;
  bool isProcessing = false;
  int totalComments = 0;
  List<dynamic> comment = [];
  Map<String, dynamic>? educationContent;

  // Mengambil data konten edukasi dan komentar berdasarkan educationId
  Future<void> fetchEducationAndComments(
      BuildContext context, int educationId, Function(bool) setLoading) async {
    setLoading(true);

    try {
      final responseContent =
          await educationService.showEducationContentDetail(educationId);
      if (responseContent.statusCode == 200) {
        educationContent = json.decode(responseContent.body);
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

  // Menghapus konten edukasi berdasarkan educationId
  Future<void> deleteEducationContent(
      BuildContext context, int educationId) async {
    final response =
        await educationService.destroyEducationContent(educationId);
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (context.mounted) {
        showSnackBar(
            context, data['message'], Color.fromARGB(255, 59, 142, 110), 2000);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/galeri_konten_edukasi',
            (Route<dynamic> route) =>
                route.isFirst || route.settings.name == '/edukasi',
          );
        }
      }
    } else if (response.statusCode == 403 || response.statusCode == 404) {
      final data = json.decode(response.body);
      if (context.mounted) {
        showSnackBar(context, data['message'],
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } else {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    }
  }

  // Menampilkan dialog konfirmasi untuk menghapus konten edukasi
  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Konten Edukasi'),
          content:
              Text('Apakah Anda yakin ingin menghapus Konten Edukasi ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: isProcessing
                  ? null
                  : () async {
                      await deleteEducationContent(
                          context, educationContent!['ID_Edukasi']);
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

  // Menampilkan snackbar dengan pesan tertentu
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
