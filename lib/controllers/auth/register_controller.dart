import 'dart:convert'; // Mengimpor library untuk encoding dan decoding JSON
import 'package:flutter/material.dart'; // Mengimpor library Flutter untuk widget dan material design
import 'package:trashify/services/account_service.dart'; // Mengimpor layanan autentikasi

class RegisterController {
  // Inisialisasi layanan autentikasi
  final AccountService service = AccountService();

  // Kontroler untuk input nama, email, password, dan konfirmasi password
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  // Kunci untuk form validasi
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Variabel untuk mengontrol visibilitas password dan status pemrosesan
  bool isPasswordVisible = false;
  bool isConfirmationPasswordVisible = false;
  bool isProcessing = false;

  // Fungsi untuk melakukan registrasi pengguna
  Future<void> register(BuildContext context) async {
    // Validasi form sebelum melanjutkan
    if (!formKey.currentState!.validate()) {
      return; // Jika tidak valid, keluar dari fungsi
    } else {
      isProcessing =
          true; // Menandakan bahwa proses registrasi sedang berlangsung

      // Mengirim permintaan registrasi ke layanan autentikasi
      final response = await service.register(
        nameController.text, // Mengambil nama dari kontroler
        emailController.text, // Mengambil email dari kontroler
        passwordController.text, // Mengambil password dari kontroler
      );

      try {
        // Jika registrasi berhasil (status code 201)
        if (response.statusCode == 201) {
          final data = json.decode(response.body); // Decode response JSON

          // Mengarahkan pengguna ke halaman login setelah registrasi berhasil
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/masuk');
          }

          // Menampilkan snackbar dengan pesan sukses
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 300);
          }
        }
        // Jika email sudah terdaftar (status code 409)
        else if (response.statusCode == 409) {
          final data = json.decode(response.body); // Decode response JSON

          // Menampilkan snackbar dengan pesan kesalahan
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        }
        // Jika terjadi kesalahan validasi (status code 422) atau kesalahan server (status code 500)
        else if (response.statusCode == 422 || response.statusCode == 500) {
          final data = json.decode(response.body); // Decode response JSON

          // Menampilkan snackbar dengan pesan kesalahan
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        }
        // Jika terjadi kesalahan lain
        else {
          if (context.mounted) {
            showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62), 2000);
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
        isProcessing = false; // Mengatur status pemrosesan kembali ke false
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
