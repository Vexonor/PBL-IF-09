import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/auth/register_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: controller.formKey,
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
                          controller: controller.nameController,
                          textInputAction: TextInputAction.next,
                          enabled: !controller.isProcessing,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.people, color: Colors.black),
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            errorMaxLines: 2,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !controller.isProcessing,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Colors.black),
                            labelText: 'Alamat Email',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            errorMaxLines: 2,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong!';
                            }
                            String pattern =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'Format email tidak valid!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.passwordController,
                          textInputAction: TextInputAction.next,
                          enabled: !controller.isProcessing,
                          obscureText: !controller.isPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.black),
                            labelText: 'Kata Sandi',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  controller.isPasswordVisible =
                                      !controller.isPasswordVisible;
                                });
                              },
                            ),
                            errorMaxLines: 2,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kata Sandi tidak boleh kosong!';
                            }
                            if (value.length < 8) {
                              return 'Kata Sandi harus terdiri dari minimal 8 karakter!';
                            }
                            if (!RegExp(r'\d').hasMatch(value)) {
                              return 'Kata Sandi harus setidaknya satu angka!';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Kata Sandi harus setidaknya satu huruf besar!';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.passwordConfirmationController,
                          enabled: !controller.isProcessing,
                          obscureText:
                              !controller.isConfirmationPasswordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.black),
                            labelText: 'Konfirmasi Kata Sandi',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmationPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  controller.isConfirmationPasswordVisible =
                                      !controller.isConfirmationPasswordVisible;
                                });
                              },
                            ),
                            errorMaxLines: 2,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi Kata Sandi tidak boleh kosong!';
                            }
                            if (value != controller.passwordController.text) {
                              return 'Kata Sandi tidak sesuai!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 75.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 59, 142, 110),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: controller.isProcessing
                                  ? null
                                  : () {
                                      setState(() {
                                        controller.isProcessing =
                                            true;
                                      });
                                      controller.register(context).then((_) {
                                        setState(() {
                                          controller.isProcessing =
                                              false;
                                        });
                                      }).catchError((error) {
                                        setState(() {
                                          controller.isProcessing =
                                              false;
                                        });
                                      });
                                    },
                              child: controller.isProcessing
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text(
                                      'Daftar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
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
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/masuk');
                              },
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 59, 142, 110),
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
          ),
        ],
      ),
    );
  }
}
