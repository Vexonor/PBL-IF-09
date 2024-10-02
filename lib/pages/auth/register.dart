import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/auth/login.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formkey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (_nameController.text.trim().isEmpty &&
        _emailController.text.trim().isEmpty &&
        _passwordController.text.trim().isEmpty &&
        _confirmPasswordController.text.trim().isEmpty) {
      _showErrorDialog('Nama, Email, atau Kata Sandi tidak boleh kosong!');
      return;
    } else if (_nameController.text.trim().isEmpty) {
      _showErrorDialog('Nama tidak boleh kosong!');
      return;
    } else if (_emailController.text.trim().isEmpty) {
      _showErrorDialog('Email tidak boleh kosong!');
      return;
    } else if (_passwordController.text.trim().isEmpty) {
      _showErrorDialog('Kata Sandi tidak boleh kosong!');
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog("Kata Sandi tidak sesuai!");
      return;
    }

    try {
      String userId = Uuid().v4();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'userId': userId,
      });

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'Kata sandi terlalu lemah!';
      } else if (e.code == 'email-already-in-use') {
        message = 'Alamat Email telah terdaftar!';
      } else if (e.code == 'invalid-email') {
        message = 'Alamat email tidak valid!';
      } else {
        message = 'Pendaftaran gagal. Mohon coba lagi!';
      }
      _showErrorDialog(message);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (alert) => AlertDialog(
        title: Text(
          'Daftar Gagal',
          style: GoogleFonts.poppins(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Colors.red
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  Color.fromARGB(255, 54, 133, 102)),
            ),
            onPressed: () {
              Navigator.of(alert).pop();
            },
            child: Text(
              'Oke',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 133, 102),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  'assets/images/trashify.png',
                  width: 150,
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 7.0),
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                        'Daftar',
                        style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.people, color: Colors.grey),
                                  labelText: 'Nama Lengkap',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey
                                  ),
                                  labelText: 'Alamat Email',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.grey
                                  ),
                                  labelText: 'Kata Sandi',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Colors.grey),
                                  labelText: 'Konfirmasi Kata Sandi',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                                child: ElevatedButton(
                                  onPressed: _register,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:const Color.fromARGB(255, 54, 133, 102),
                                    minimumSize: Size(10, 50),
                                  ),
                                  child: Text(
                                    'Daftar',
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sudah memiliki akun?",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF8c8e98),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                  SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LogIn()
                                          )
                                      );
                                    },
                                    child: Text(
                                      "Masuk",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xFF273671),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
