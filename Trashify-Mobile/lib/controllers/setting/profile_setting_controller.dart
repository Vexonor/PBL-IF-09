import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/services/account_service.dart';

class ProfileSettingController {
  final AccountService service = AccountService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  bool isProcessing = false;
  bool imageValidatorError = false;
  String? currentProfilePicture;
  String? imageValidator;
  String? selectedGender;
  XFile? profilePicture;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    profilePicture = await picker.pickImage(source: ImageSource.gallery);
  }

  // Fungsi untuk mengirim data pengguna ke server
  Future<void> submitData(BuildContext context, int userId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isProcessing = true;

    Uint8List? imageBytes;
    String? fileName;

    if (profilePicture != null) {
      imageBytes = await profilePicture!.readAsBytes();
      fileName = profilePicture!.name;
    } else if (currentProfilePicture != null) {
      imageBytes = null;
      fileName = null;
    } else {
      imageBytes = null;
      fileName = null;
    }

    final response = await service.updateUserData(
      userId.toString(),
      nameController.text,
      emailController.text,
      nikController.text,
      numberController.text,
      addressController.text,
      birthDateController.text,
      selectedGender!,
      imageBytes,
      fileName,
    );

    try {
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        if (context.mounted) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          await userProvider.updateUserData(
            userId: userId,
            userName: nameController.text,
            userEmail: emailController.text,
            userNumber: numberController.text,
            userAddress: addressController.text,
            userGender: selectedGender!,
            userNik: int.parse(nikController.text),
            userDateBirth: birthDateController.text,
            userPhoto: data['Foto_Profil'],
          );
        }
        if (context.mounted) {
          showSnackBar(context, data['message'],
              Color.fromARGB(255, 59, 142, 110), 2000);
        }
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else if (response.statusCode == 422) {
        if (context.mounted) {
          showSnackBar(context, 'Ukuran gambar terlalu besar!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else {
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
      isProcessing = false;
    }
  }

  // Fungsi untuk menampilkan snackbar dengan pesan
  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 20.0 + keyboardHeight,
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