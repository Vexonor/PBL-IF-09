import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController {
  Future<void> checkUserLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Mendapatkan instance SharedPreferences
    String? session =
        prefs.getString('token'); // Mengambil token dari SharedPreferences

    // // Jika token ada, arahkan pengguna ke halaman utama
    if (session == null) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/masuk', // Ganti dengan nama route yang sesuai
          (Route<dynamic> route) => route.settings.name == '/masuk',
        );
      }
    }
  }
}
