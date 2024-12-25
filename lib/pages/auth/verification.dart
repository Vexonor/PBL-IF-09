import 'package:flutter/material.dart';
import 'package:trashify/controllers/auth/verification_controller.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final VerificationController controller = VerificationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi Email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masukkan Kode Verifikasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Kami telah mengirimkan kode verifikasi ke email Anda. Silakan masukkan kode di bawah ini.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.verificationCodeController,
              decoration: InputDecoration(
                labelText: 'Kode Verifikasi',
                border: OutlineInputBorder(),
                hintText: 'Masukkan kode di sini',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.verification(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Verifikasi'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Logika untuk mengirim ulang kode verifikasi
              },
              child: Text('Kirim Ulang Kode'),
            ),
          ],
        ),
      ),
    );
  }
}
