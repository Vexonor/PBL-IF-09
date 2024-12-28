import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController {
  // Memeriksa status login pengguna
  Future<void> checkUserLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? session = prefs.getString('token');

    if (session == null) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/masuk',
          (Route<dynamic> route) => route.settings.name == '/masuk',
        );
      }
    }
  }
}
