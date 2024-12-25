import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/setting/password_setting_controller.dart';
import 'package:trashify/providers/user_provider.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({super.key});

  @override
  State<PasswordSetting> createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  final PasswordSettingController controller = PasswordSettingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the UserProvider here
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ganti Kata Sandi',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Form(
                            key: controller.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Untuk memperbarui kata sandi anda, Mohon masukkan kada sandi anda yang lama',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.oldPasswordController,
                                  textInputAction: TextInputAction.next,
                                  enabled: !controller.isProcessing,
                                  obscureText: !controller.isOldPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    labelText: 'Kata Sandi Lama',
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isOldPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          controller.isOldPasswordVisible =
                                              !controller.isOldPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Kata Sandi tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.newPasswordController,
                                  enabled: !controller.isProcessing,
                                  obscureText: !controller.isNewPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    labelText: 'Kata Sandi Baru',
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isNewPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          controller.isNewPasswordVisible =
                                              !controller.isNewPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Konfirmasi Kata Sandi tidak boleh kosong!';
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
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: controller
                                      .newConfirmationPasswordController,
                                  enabled: !controller.isProcessing,
                                  obscureText: !controller
                                      .isNewConfirmationPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    labelText: 'Konfirmasi Kata Sandi Baru',
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller
                                                .isNewConfirmationPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          controller
                                                  .isNewConfirmationPasswordVisible =
                                              !controller
                                                  .isNewConfirmationPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Konfirmasi Kata Sandi tidak boleh kosong!';
                                    }
                                    if (value !=
                                        controller.newPasswordController.text) {
                                      return 'Kata Sandi tidak sesuai!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 75.0),
                                    child: ElevatedButton(
                                      onPressed: controller.isProcessing
                                          ? null
                                          : () {
                                              setState(() {
                                                controller.isProcessing =
                                                    true; // Set isProcessing to true
                                              });

                                              controller
                                                  .submitData(context, userId)
                                                  .then((_) {
                                                // Setelah proses submit selesai, set isProcessing kembali ke false
                                                setState(() {
                                                  controller.isProcessing =
                                                      false;
                                                });
                                              }).catchError((error) {
                                                // Tangani error jika ada
                                                setState(() {
                                                  controller.isProcessing =
                                                      false; // Pastikan untuk mengatur kembali ke false
                                                });
                                                // Anda bisa menampilkan pesan kesalahan di sini jika diperlukan
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Terjadi kesalahan: $error')),
                                                  );
                                                  controller.showSnackBar(
                                                      context,
                                                      'Terjadi kesalahan: $error',
                                                      const Color.fromARGB(
                                                          255, 181, 61, 62),
                                                      2000);
                                                }
                                              });
                                            },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        backgroundColor: const Color.fromARGB(
                                            255, 59, 142, 110),
                                      ),
                                      child: controller.isProcessing
                                          ? SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text('Ubah',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Atau jika anda lupa kata sandi sebelumnya bisa menggunakan fitur Lupa Kata Sandi',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
