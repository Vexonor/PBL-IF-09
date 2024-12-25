import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/complaint/complaint_add_controller.dart';

class ComplaintAdd extends StatefulWidget {
  final String? initialCategory;
  final String? initialCoordinates;
  final String? initialDescription;

  const ComplaintAdd(
      {super.key,
      this.initialCategory,
      this.initialCoordinates,
      this.initialDescription});

  @override
  State<ComplaintAdd> createState() => _ComplaintAddState();
}

class _ComplaintAddState extends State<ComplaintAdd> {
  final ComplaintAddController controller = ComplaintAddController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      controller.complaintCategory = widget.initialCategory;
    } else {
      controller.complaintCategory = 'Pengangkutan Sampah';
    }
    if (widget.initialCoordinates != null) {
      controller.coordinateController.text = widget.initialCoordinates!;
    }
    if (widget.initialDescription != null) {
      controller.complaintDescriptionController.text =
          widget.initialDescription!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/pengaduan',
          (Route<dynamic> route) => route.isFirst,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 59, 142, 110),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (mounted) {
                Navigator.pushNamed(context, '/pengaduan');
              }
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Tambah Pengaduan',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mengadukan terkait:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.complaintDescriptionController,
                    enabled: !controller.isProcessing,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Ketikan keluhan Anda di sini',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.coordinateController,
                    enabled: !controller.isProcessing,
                    readOnly: true,
                    onTap: controller.isProcessing
                        ? null
                        : () => controller.openMapToSelectCoordinate(context),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Ketuk untuk memilih koordinat dari map',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.isProcessing
                          ? null
                          : () async {
                              await controller
                                  .selectImages(context);
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
                        backgroundColor: controller.imageValidatorError
                            ? const Color.fromARGB(255, 172, 42, 32)
                            : const Color.fromARGB(255, 59, 142, 110),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  if (controller.imageValidator != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        controller.imageValidator!,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 172, 42, 32),
                          fontSize: 12.0,
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
                    ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: controller.isProcessing
                          ? null
                          : () {
                              setState(() {
                                controller.imageValidator = null;
                                controller.imageValidatorError = false;
                              });
                              if (controller.validateForm()) {
                                controller.submitComplaint(context);
                              } else {
                                setState(() {
                                  controller.imageValidator =
                                      controller.imageValidator;
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 59, 142, 110),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
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
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
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
      ),
    );
  }

  Widget _buildRadioInput(String category) {
    return RadioListTile<String>(
      value: category,
      groupValue: controller.complaintCategory,
      onChanged: controller.isProcessing
          ? null
          : (String? value) {
              setState(() {
                controller.complaintCategory = value;
              });
            },
      title: Text(
        category,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
