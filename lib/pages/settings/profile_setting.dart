import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/setting/profile_setting_controller.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/services/global_url.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final ProfileSettingController controller = ProfileSettingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the UserProvider here
    Provider.of<UserProvider>(context, listen: false).loadUserData();
    controller.currentProfilePicture =
        Provider.of<UserProvider>(context).userPhoto!;
    controller.nameController.text =
        Provider.of<UserProvider>(context).userName!;
    controller.emailController.text =
        Provider.of<UserProvider>(context).userEmail!;
    controller.nikController.text =
        Provider.of<UserProvider>(context).userNik!.toString();
    controller.numberController.text =
        Provider.of<UserProvider>(context).userNumber!;
    controller.addressController.text =
        Provider.of<UserProvider>(context).userAddress!;
    controller.birthDateController.text =
        Provider.of<UserProvider>(context).userDateBirth!;
    controller.selectedGender = Provider.of<UserProvider>(context).userGender!;
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
                    'Ubah Profil',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Foto Profil',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Stack(
                    alignment: Alignment
                        .bottomRight, // Menempatkan ikon di bawah kanan
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300], // Warna lingkaran
                        ),
                        child: controller.profilePicture == null
                            ? (controller.currentProfilePicture != null &&
                                        controller.currentProfilePicture != ''
                                    ? ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '$imageStorageUrl/${controller.currentProfilePicture!}',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.add, size: 40) // Ikon plus
                                )
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
                          color: Colors.white, // Latar belakang untuk ikon edit
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit,
                              color: const Color.fromARGB(255, 59, 142, 110)),
                          onPressed: controller.isProcessing
                              ? null
                              : () async {
                                  await controller.pickImage();
                                  setState(
                                      () {}); // Memanggil setState untuk memperbarui UI
                                },
                          iconSize: 15, // Ukuran ikon edit lebih kecil
                        ),
                      ),
                    ],
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
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.nameController,
                                  textInputAction: TextInputAction.next,
                                  enabled: !controller.isProcessing,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.people,
                                        color: Colors.grey),
                                    labelText: 'Nama Lengkap',
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nama tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.emailController,
                                  textInputAction: TextInputAction.next,
                                  enabled: !controller.isProcessing,
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
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.nikController,
                                  enabled: !controller.isProcessing,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.credit_card,
                                        color: Colors.grey),
                                    labelText: 'NIK',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
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
                                  controller: controller.numberController,
                                  enabled: !controller.isProcessing,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.phone,
                                        color: Colors.grey),
                                    labelText: 'No Telepon',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
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
                                    prefixIcon: const Icon(Icons.home,
                                        color: Colors.grey),
                                    labelText: 'Alamat',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
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
                                  readOnly:
                                      true, // Agar tidak bisa diedit langsung
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.calendar_today,
                                        color: Colors.grey),
                                    labelText: 'Tanggal Lahir',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onTap: controller.isProcessing
                                      ? null
                                      : () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
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
                                              controller.birthDateController
                                                      .text =
                                                  formattedDate; // Set tanggal yang dipilih
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
                                    prefixIcon: const Icon(Icons.person,
                                        color: Colors.grey),
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
                                            controller.selectedGender =
                                                value; // Simpan pilihan gender di controller
                                          });
                                        },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Jenis Kelamin tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  // Mengatur dropdown menu
                                  dropdownColor: Colors
                                      .white, // Mengatur warna latar belakang dropdown menu
                                  // Mengatur style untuk dropdown menu
                                  itemHeight: 50,
                                  borderRadius: BorderRadius.circular(15.0),
                                  isExpanded: true,
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
                                const SizedBox(height: 5),
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
