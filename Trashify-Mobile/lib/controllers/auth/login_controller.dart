import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/account_service.dart';

class LoginController {
  final AccountService service = AccountService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isProcessing = false;
  int userNik = 0;
  String userAddress = '';
  String userDateBirth = '';
  String userGender = '';
  String userNumber = '';
  String userPhoto = '';

  // Fungsi untuk melakukan login
  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;

      final response =
          await service.login(emailController.text, passwordController.text);

      try {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();

          userNumber = data['No_Telp'] ?? '';
          userAddress = data['Alamat'] ?? '';
          userGender = data['Jenis_Kelamin'] ?? '';
          userNik = data['Nik'] ?? 0;
          userDateBirth = data['Tanggal_Lahir'] ?? '';
          userPhoto = data['Foto_Profil'] ?? '';

          await prefs.setInt('userId', data['ID_User']);
          await prefs.setString('userName', data['Nama']);
          await prefs.setString('userEmail', data['Email']);
          await prefs.setString('userNumber', userNumber);
          await prefs.setString('userAddress', userAddress);
          await prefs.setString('userGender', userGender);
          await prefs.setInt('userNik', userNik);
          await prefs.setString('userDateBirth', userDateBirth);
          await prefs.setString('userPhoto', userPhoto);

          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 300);
          }
          await Future.delayed(Duration(milliseconds: 60));

          if (userNumber == '' &&
              userAddress == '' &&
              userDateBirth == '' &&
              userGender == '' &&
              userNik == 0) {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/pembuka');
            }
          } else {
            await prefs.setString('token', data['token']);
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/halaman_utama');
            }
          }
        } else if (response.statusCode == 403) {
          final data = json.decode(response.body);
          if (context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              '/verifikasi',
              arguments: {
                'userId': data['ID_User'].toString(),
              },
            );
          }
        } else if (response.statusCode == 401 || response.statusCode == 404) {
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
  }

  // Fungsi untuk memeriksa status login pengguna
  Future<void> checkUserLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? session = prefs.getString('token');

    if (session != null) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/halaman_utama',
          (Route<dynamic> route) => route.settings.name == '/halaman_utama',
        );
      }
    }
  }

  // Fungsi untuk menampilkan snackbar dengan pesan
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
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
