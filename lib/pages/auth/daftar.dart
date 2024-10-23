import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/auth/masuk.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _kataSandiController = TextEditingController();
  final _konfirmasiKataSandiController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> _daftar() async {
    if (_namaController.text.trim().isEmpty &&
        _emailController.text.trim().isEmpty &&
        _kataSandiController.text.trim().isEmpty &&
        _konfirmasiKataSandiController.text.trim().isEmpty) {
      _tampilkanModalError('Nama, Email, atau Kata Sandi tidak boleh kosong!');
      return;
    } else if (_namaController.text.trim().isEmpty) {
      _tampilkanModalError('Nama tidak boleh kosong!');
      return;
    } else if (_emailController.text.trim().isEmpty) {
      _tampilkanModalError('Email tidak boleh kosong!');
      return;
    } else if (_kataSandiController.text.trim().isEmpty) {
      _tampilkanModalError('Kata Sandi tidak boleh kosong!');
      return;
    } else if (_kataSandiController.text !=
        _konfirmasiKataSandiController.text) {
      _tampilkanModalError("Kata Sandi tidak sesuai!");
      return;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Masuk()),
      );
    }
  }

  void _tampilkanModalError(String message) {
    showDialog(
      context: context,
      builder: (alert) => AlertDialog(
        title: Text(
          'Daftar Gagal',
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  const Color.fromARGB(255, 59, 142, 110)),
            ),
            onPressed: () {
              Navigator.of(alert).pop();
            },
            child: Text(
              'Oke',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 200),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/trashify.png',
                      width: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Daftar',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _namaController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.people, color: Colors.grey),
                          labelText: 'Nama Lengkap',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: Colors.grey),
                          labelText: 'Alamat Email',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _kataSandiController,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.grey),
                          labelText: 'Kata Sandi',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _konfirmasiKataSandiController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Colors.grey),
                          labelText: 'Konfirmasi Kata Sandi',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 75.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 142, 110),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _daftar,
                            child: Text(
                              'Daftar',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah memiliki akun?',
                            style: TextStyle(
                                color: const Color(0xFF8c8e98),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Masuk()));
                            },
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 59, 142, 110),
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
