import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/account_service.dart';

class PasswordSettingController {
  final AccountService service = AccountService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newConfirmationPasswordController =
      TextEditingController();

  bool isNewConfirmationPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isOldPasswordVisible = false;
  bool isProcessing = false;

  // Mengirim data untuk memperbarui password pengguna
  Future<void> submitData(BuildContext context, int userId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isProcessing = true;

    final response = await service.updateUserPassword(
      userId.toString(),
      oldPasswordController.text,
      newPasswordController.text,
    );

    try {
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              Color.fromARGB(255, 59, 142, 110), 2000);
        }
      } else if (response.statusCode == 403 ||
          response.statusCode == 404 ||
          response.statusCode == 500) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
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
          bottom: MediaQuery.of(context).size.height / 3.5 + keyboardHeight,
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
