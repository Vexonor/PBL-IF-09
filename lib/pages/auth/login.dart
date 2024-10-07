import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/auth/register.dart';
import 'package:trashify/pages/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LoginState();
}

class _LoginState extends State<LogIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_emailController.text.trim().isEmpty &&
        _passwordController.text.trim().isEmpty) {
      _showErrorDialog('Alamat Email atau Kata Sandi tidak boleh kosong!');
      return;
    } else if (_emailController.text.trim().isEmpty) {
      _showErrorDialog('Alamat Email tidak boleh kosong!');
      return;
    } else if (_passwordController.text.trim().isEmpty) {
      _showErrorDialog('Kata Sandi tidak boleh kosong!');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Alamat Email belum terdaftar!';
      } else if (e.code == 'wrong-password') {
        message = 'Kata Sandi salah!';
      } else {
        message = 'Email atau Kata Sandi tidak valid. Mohon coba lagi!';
      }
      _showErrorDialog(message);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (alert) => AlertDialog(
        title: Text(
          'Masuk Gagal',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  Color.fromARGB(255, 59, 142, 110)),
            ),
            onPressed: () {
              Navigator.of(alert).pop();
            },
            child: Text(
              'Oke',
              style: GoogleFonts.poppins(
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
      resizeToAvoidBottomInset:
          true, // Mengizinkan tampilan menyesuaikan saat keyboard terbuka
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context)
                .size
                .height, // Menyesuaikan tinggi dengan layar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 170,
                      ),
                      Image.asset(
                        'assets/images/trashify.png',
                        width: 150,
                      ),
                      Spacer(),
                      // Form Login
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Masuk',
                              style: GoogleFonts.poppins(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: Colors.grey),
                                      labelText: 'Alamat Email',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.grey),
                                labelText: 'Kata Sandi',
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 59, 142, 110),
                                  minimumSize: Size(300, 50),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Belum memiliki akun?",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xFF8c8e98),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    "Daftar",
                                    style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 59, 142, 110),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ), // Background Hijau sesuai desain
    );
  }
}
