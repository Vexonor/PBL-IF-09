import 'dart:convert'; // Mengimpor library untuk encoding dan decoding JSON
import 'package:flutter/material.dart'; // Mengimpor library Flutter untuk widget dan material design
import 'package:shared_preferences/shared_preferences.dart'; // Mengimpor library untuk menyimpan data secara lokal
import 'package:trashify/services/account_service.dart'; // Mengimpor layanan autentikasi

class LoginController {
  // Inisialisasi layanan autentikasi
  final AccountService service = AccountService();

  // Kontroler untuk input email dan password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Kunci untuk form validasi
  final formKey = GlobalKey<FormState>();

  // Variabel untuk mengontrol visibilitas password dan status pemrosesan
  bool isPasswordVisible = false;
  bool isProcessing = false;
  String userNumber = '';
  String userAddress = '';
  String userGender = '';
  int userNik = 0;
  String userDateBirth = '';
  String userPhoto = '';

  // Fungsi untuk melakukan login
  Future<void> login(BuildContext context) async {
    // Validasi form sebelum melanjutkan
    if (!formKey.currentState!.validate()) {
      return; // Jika tidak valid, keluar dari fungsi
    } else {
      isProcessing = true; // Menandakan bahwa proses login sedang berlangsung

      // Mengirim permintaan login ke layanan autentikasi
      final response =
          await service.login(emailController.text, passwordController.text);

      try {
        // Jika login berhasil (status code 200)
        if (response.statusCode == 200) {
          final data = json.decode(response.body); // Decode response JSON
          SharedPreferences prefs = await SharedPreferences
              .getInstance(); // Mendapatkan instance SharedPreferences

          userNumber = data['No_Telp'] ?? '';
          userAddress = data['Alamat'] ?? '';
          userGender = data['Jenis_Kelamin'] ?? '';
          userNik = data['Nik'] ?? 0;
          userDateBirth = data['Tanggal_Lahir'] ?? '';
          userPhoto = data['Foto_Profil'] ?? '';

          // Menyimpan data pengguna ke SharedPreferences
          await prefs.setInt('userId', data['ID_User']);
          await prefs.setString('userName', data['Nama']);
          await prefs.setString('userEmail', data['Email']);
          await prefs.setString('userNumber', userNumber);
          await prefs.setString('userAddress', userAddress);
          await prefs.setString('userGender', userGender);
          await prefs.setInt('userNik', userNik);
          await prefs.setString('userDateBirth', userDateBirth);
          await prefs.setString('userPhoto', userPhoto);

          // Menampilkan snackbar dengan pesan sukses
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 300);
          }
          await Future.delayed(
              Duration(milliseconds: 60)); // Menunggu sejenak sebelum navigasi

          // Cek apakah pengguna baru berdasarkan data yang kosong
          if (userNumber == '' &&
              userAddress == '' &&
              userDateBirth == '' &&
              userGender == '' &&
              userNik == 0) {
            // Jika pengguna baru, arahkan ke halaman welcome
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/pembuka');
            }
          } else {
            await prefs.setString('token', data['token']);
            // Jika bukan pengguna baru, arahkan ke halaman utama
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/halaman_utama');
            }
          }
        }
        // Jika kredensial salah (status code 401)
        else if (response.statusCode == 401) {
          final data = json.decode(response.body); // Decode response JSON

          // Menampilkan snackbar dengan pesan kesalahan
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        }
        // Jika pengguna tidak ditemukan (status code 404)
        else if (response.statusCode == 404) {
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

  // Fungsi untuk memeriksa status login pengguna
  Future<void> checkUserLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Mendapatkan instance SharedPreferences
    String? session =
        prefs.getString('token'); // Mengambil token dari SharedPreferences

    // // Jika token ada, arahkan pengguna ke halaman utama
    if (session != null) {
      if (context.mounted) {
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/halaman_utama', // Ganti dengan nama route yang sesuai
            (Route<dynamic> route) => route.settings.name == '/halaman_utama',
          );
        }
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
