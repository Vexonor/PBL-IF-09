import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/auth/welcome_controller.dart';
import 'package:trashify/providers/user_provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final WelcomeController controller = WelcomeController();

  @override
  void initState() {
    super.initState();
    // Memuat data pengguna saat inisialisasi
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Sumber Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Kamera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.pickImage(source: ImageSource.camera).then((_) {
                      setState(() {});
                    });
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Galeri"),
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.pickImage(source: ImageSource.gallery).then((_) {
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Text(
                        'Sebelum melanjutkan, Silakan lengkapi data diri Anda terlebih dahulu.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Foto Profil',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: controller.profilePicture == null
                                ? Icon(Icons.add, size: 40)
                                : ClipOval(
                                    child: Image.file(
                                      File(controller.profilePicture!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 59, 142, 110),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: controller.isProcessing
                                  ? null
                                  : () async {
                                      _showImagePickerDialog();
                                    },
                              iconSize: 15,
                            ),
                          ),
                        ],
                      ),
                      if (controller.imageValidatorError)
                        Text(
                          controller.imageValidator ?? '',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 181, 61, 62),
                          ),
                        ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controller.nikController,
                        enabled: !controller.isProcessing,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.credit_card,
                              color: Colors.black),
                          labelText: 'NIK',
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
                            return 'NIK tidak boleh kosong';
                          }
                          if (value.length != 16) {
                            return 'NIK harus terdiri dari 16 digit';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'NIK hanya boleh terdiri dari angka';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controller.phoneController,
                        enabled: !controller.isProcessing,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.black),
                          labelText: 'No Telepon',
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
                            return 'No Telepon tidak boleh kosong';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'No Telepon hanya boleh angka';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controller.addressController,
                        enabled: !controller.isProcessing,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.home, color: Colors.black),
                          labelText: 'Alamat',
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
                            return 'Alamat tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: controller.birthDateController,
                        enabled: !controller.isProcessing,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today,
                              color: Colors.black),
                          labelText: 'Tanggal Lahir',
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
                        onTap: controller.isProcessing
                            ? null
                            : () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    controller.birthDateController.text =
                                        formattedDate;
                                  });
                                }
                              },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Lahir tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: controller.selectedGender,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                          labelText: 'Jenis Kelamin',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'Laki-laki',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'Perempuan',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: controller.isProcessing
                            ? null
                            : (value) {
                                setState(() {
                                  controller.selectedGender = value;
                                });
                              },
                        validator: (value) {
                          if (value == null) {
                            return 'Jenis Kelamin tidak boleh kosong';
                          }
                          return null;
                        },
                        dropdownColor: Colors.white,
                        itemHeight: 50,
                        borderRadius: BorderRadius.circular(15.0),
                        isExpanded: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.isProcessing
                            ? null
                            : () {
                                setState(() {
                                  controller.isProcessing = true;
                                });
                                controller
                                    .submitData(context, userId!)
                                    .then((_) {
                                  setState(() {
                                    controller.isProcessing = false;
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    controller.isProcessing = false;
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Terjadi kesalahan: $error')),
                                    );
                                    controller.showSnackBar(
                                        context,
                                        'Terjadi kesalahan: $error',
                                        const Color.fromARGB(255, 181, 61, 62),
                                        2000);
                                  }
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor:
                              const Color.fromARGB(255, 59, 142, 110),
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
                            : Text(
                                'Kirim',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
