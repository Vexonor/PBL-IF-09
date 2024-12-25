import 'package:flutter/material.dart';
import 'package:trashify/services/account_service.dart';

class VerificationController with ChangeNotifier {
  final AccountService service = AccountService();
  final TextEditingController verificationCodeController =
      TextEditingController();

  Future<void> verification(BuildContext context) async {
    final response =
        await service.verification(verificationCodeController.text);
    if (response.statusCode == 200) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/masuk');
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kode verifikasi salah atau kadaluarsa.'),
            backgroundColor: const Color.fromARGB(255, 181, 61, 62),
          ),
        );
      }
    }
  }
}
