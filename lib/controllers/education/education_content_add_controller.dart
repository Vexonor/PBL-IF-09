import 'dart:convert'; // For JSON conversion
import 'package:trashify/services/education_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For Flutter widgets

class EducationContentAddController {
  final EducationService service = EducationService();
  final videoUrlController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isProcessing = false;
  String contentType = 'Artikel';
  int? userId;

  EducationContentAddController() {
    init();
  }

  Future<void> init() async {
    await _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

  Future<void> submitEducationContent(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;

      String videoUrl =
          contentType == 'Artikel' ? 'null' : videoUrlController.text;

      // Mengirim pengaduan
      final response = await service.storeEducationContent(
        userId!.toString(),
        titleController.text,
        videoUrl,
        descriptionController.text,
        contentType,
      );

      try {
        if (response.statusCode == 201) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 2000);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/galeri_konten_edukasi', // Ganti dengan nama route yang sesuai
              (Route<dynamic> route) =>
                  route.isFirst || route.settings.name == '/edukasi',
            );
          }
        } else if (response.statusCode == 500) {
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
        } // Menangani pengecualian
      } finally {
        isProcessing = false; // Set loading menjadi false
        (context as Element).markNeedsBuild();
      }
    }
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
