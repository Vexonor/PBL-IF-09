import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trashify/services/account_service.dart';

class VerificationController with ChangeNotifier {
  final AccountService service = AccountService();

  bool isLoading = true;
  bool isProcessing = false;
  Map<String, dynamic>? verificationInformation;
  String? userId;

  // Mengatur ID user
  void setUserId(String id) {
    userId = id;
  }

  // Mengambil detail verifikasi dari layanan
  Future<void> fetchVerification(BuildContext context) async {
    isLoading = true;

    try {
      if (userId != null) {
        final response = await service.getVerification(userId!);
        if (response.statusCode == 200) {
          verificationInformation = json.decode(response.body);
        } else if (response.statusCode == 404) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        } else {
          if (context.mounted) {
            showSnackBar(context, 'Gagal memuat verifikasi, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> verification(BuildContext context, String code) async {
    isProcessing = true;

    try {
      final response = await service.verification(code, userId!);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/masuk');
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 59, 142, 110), 2000);
        }
      }
      else if (response.statusCode == 403) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Input kode tidak boleh kosong!',
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

  Future<void> resendOtp(BuildContext context) async {
    isProcessing = true;

    try {
      final response = await service.resendOtp(userId!);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/verifikasi',
            arguments: {
              'userId': userId!.toString(),
            },
          );
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 59, 142, 110), 2000);
        }
      }
      else if (response.statusCode == 404 || response.statusCode == 401) {
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
    }
  }

  // Menampilkan snackbar dengan pesan
  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 20.0 + keyboardHeight,
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
