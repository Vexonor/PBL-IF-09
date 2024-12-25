import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/complaint/complaint_edit_controller.dart';
import 'package:trashify/services/global_url.dart';

class ComplaintEdit extends StatefulWidget {
  const ComplaintEdit({super.key});

  @override
  State<ComplaintEdit> createState() => _ComplaintEditState();
}

class _ComplaintEditState extends State<ComplaintEdit> {
  final ComplaintEditController controller = ComplaintEditController();
  bool isDataLoaded = false; // Tambahkan flag ini

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isDataLoaded) {
      // Cek apakah data sudah dimuat
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final complaintId = args['complaintId'];

      controller.loadComplaintData(context, complaintId).then((_) {
        if (mounted) {
          setState(() {
            isDataLoaded = true; // Set flag ke true setelah data dimuat
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (mounted) {
              Navigator.pop(context);
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Edit Pengaduan',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      body: controller.isLoading // Cek apakah sedang loading
          ? Center(child: CircularProgressIndicator()) // Tampilkan loading
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mengadukan terkait:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          _buildRadioInput('Pengangkutan Sampah'),
                          _buildRadioInput('Kondisi TPS'),
                          _buildRadioInput('Tempat Sampah Liar'),
                          _buildRadioInput('Lainnya'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Deskripsi Pengaduan:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: controller.complaintDescriptionController,
                        enabled: !controller.isProcessing,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Ketikan keluhan Anda di sini',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('Titik Koordinat:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: controller.coordinateController,
                        enabled: !controller.isProcessing,
                        readOnly: true,
                        onTap: controller.isProcessing
                            ? null
                            : () =>
                                controller.openMapToSelectCoordinate(context),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Ketuk untuk memilih koordinat dari map',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                            suffixIcon: const SizedBox(
                              child: Icon(Icons.map),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Titik koordinat tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('Gambar Pengaduan:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: controller.isProcessing
                              ? null
                              : () async {
                                  await controller.selectImages(context);
                                  setState(() {});
                                },
                          icon: const Icon(
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Pilih Gambar',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 142, 110),
                          ),
                        ),
                      ),
                      if (controller.selectedImages!.isNotEmpty)
                        Column(
                          children: controller.selectedImages!.map((image) {
                            return Container(
                              height: 200,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: FileImage(File(image.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      else if (controller.imageUrl != null &&
                          controller.imageUrl!.isNotEmpty)
                        Column(
                          children: controller.imageUrl!.map((image) {
                            return Container(
                              height: 200,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '$imageStorageUrl/$image'), // Pastikan ini adalah URL yang valid
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: controller.isProcessing
                              ? null // Nonaktifkan tombol jika isProcessing adalah true
                              : () {
                                  controller.submitComplaint(context,
                                      (isProcessing) {
                                    setState(() {
                                      controller.setProcessing(isProcessing);
                                    });
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 142, 110),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: controller.isProcessing
                              ? SizedBox(
                                  width:
                                      24, // Set width for the CircularProgressIndicator
                                  height:
                                      24, // Set height for the CircularProgressIndicator
                                  child: CircularProgressIndicator(
                                    color: Colors
                                        .white, // Set the color of the progress indicator
                                    strokeWidth: 2, // Set the stroke width
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Add some spacing between icon and text
                                    Text(
                                      'Kirim',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildRadioInput(String title) {
    return RadioListTile<String>(
      value: title,
      groupValue: controller.complaintCategory,
      onChanged: controller.isProcessing
          ? null
          : (String? value) {
              setState(() {
                controller.complaintCategory = value;
              });
            },
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
