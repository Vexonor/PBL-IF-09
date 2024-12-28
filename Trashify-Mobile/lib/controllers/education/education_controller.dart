import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/comment_service.dart';
import 'package:trashify/services/education_service.dart';

class EducationController {
  final CommentService commentService = CommentService();
  final EducationService educationService = EducationService();

  bool isLoading = false;
  List<dynamic>? allContent;
  List<dynamic>? comment;
  List<dynamic>? educationContent;
  List<String> suggestions = [];
  String searchQuery = '';

  // Mengambil konten edukasi dan komentar dari layanan
  Future<void> fetchEducationContent(
      BuildContext context, Function(bool) setLoading) async {
    setLoading(true); // Mulai loading

    try {
      final response = await educationService.getEducationContent();
      if (response.statusCode == 200) {
        if (context.mounted) {
          allContent = json.decode(response.body);

          List<dynamic> videoContent = allContent!
              .where((item) =>
                  item['Jenis_Edukasi'] == 'Video' &&
                  item['Status_Edukasi'] == 'Telah Diunggah')
              .toList();
          List<dynamic> artikelContent = allContent!
              .where((item) =>
                  item['Jenis_Edukasi'] == 'Artikel' &&
                  item['Status_Edukasi'] == 'Telah Diunggah')
              .toList();

          videoContent.sort((a, b) => DateTime.parse(b['created_at'])
              .compareTo(DateTime.parse(a['created_at'])));
          artikelContent.sort((a, b) => DateTime.parse(b['created_at'])
              .compareTo(DateTime.parse(a['created_at'])));

          educationContent = [...videoContent, ...artikelContent];
        }
      } else {
        if (context.mounted) {
          showSnackBar(
              context,
              'Gagal memuat Konten Edukasi, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62),
              2000);
        }
      }

      // Mengambil komentar
      final responseComment = await commentService.getComment();
      if (responseComment.statusCode == 200) {
        comment = json.decode(responseComment.body);
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Gagal memuat Komentar, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false); // Menghentikan loading
    }
  }

  // Menampilkan snackbar dengan pesan tertentu
  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 100.0 + keyboardHeight,
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
