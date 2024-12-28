import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/education_service.dart';

class EducationContentEditController {
  final EducationService service = EducationService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  bool isLoading = false;
  bool isProcessing = false;
  Map<String, dynamic>? educationContent;
  String contentType = 'Artikel';

  // Mengambil konten edukasi untuk diedit
  Future<void> fetchEducationContentEdit(
      BuildContext context, int educationId, Function(bool) setLoading) async {
    setLoading(true);
    try {
      final responseContent =
          await service.showEducationContentEdit(educationId);
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
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false);
    }
  }

  // Mengirim konten edukasi yang telah diedit
  Future<void> submitEducationContent(
      BuildContext context, int educationId) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;
      String videoUrl =
          contentType == 'Artikel' ? 'null' : videoUrlController.text;

      final response = await service.updateEducationContent(
        educationId,
        titleController.text,
        videoUrl,
        descriptionController.text,
        contentType,
      );

      try {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 2000);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/detail_konten_edukasi',
              (Route<dynamic> route) =>
                  route.isFirst ||
                  route.settings.name == '/edukasi' ||
                  route.settings.name == '/galeri_konten_edukasi',
              arguments: {'educationId': educationId},
            );
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
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } finally {
        isProcessing = false;
        (context as Element).markNeedsBuild();
      }
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
