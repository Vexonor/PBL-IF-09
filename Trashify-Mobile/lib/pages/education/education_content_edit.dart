import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/education/education_content_edit_controller.dart';

class EducationContentEdit extends StatefulWidget {
  const EducationContentEdit({super.key});

  @override
  State<EducationContentEdit> createState() => _EducationContentEditState();
}

class _EducationContentEditState extends State<EducationContentEdit> {
  final EducationContentEditController controller =
      EducationContentEditController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final educationId = args['educationId'];
    controller.fetchEducationContentEdit(context, educationId, (loading) {
      if (mounted) {
        setState(() {
          controller.isLoading = loading;
          if (controller.educationContent != null) {
            controller.contentType =
                controller.educationContent!['Jenis_Edukasi'] ?? '';
            controller.titleController.text =
                controller.educationContent!['Judul_Edukasi'] ?? '';
            controller.descriptionController.text =
                controller.educationContent!['Deskripsi_Edukasi'] ?? '';
            controller.videoUrlController.text =
                controller.educationContent!['Link_URL'] ?? '';
          } else {
            controller.contentType = '';
            controller.titleController.text = '';
            controller.descriptionController.text = '';
            controller.videoUrlController.text = '';
          }
        });
      }
    });
  }

  @override
  void dispose() {
    controller.videoUrlController.dispose();
    controller.titleController.dispose();
    controller.descriptionController.dispose();
    super.dispose();
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
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Edit Konten Edukasi',
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
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Konten:', style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        Radio(
                          value: 'Artikel',
                          groupValue: controller.contentType,
                          onChanged: null,
                        ),
                        Text('Artikel', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 20),
                        Radio(
                          value: 'Video',
                          groupValue: controller.contentType,
                          onChanged: null,
                        ),
                        Text('Video', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (controller.contentType == 'Video')
                      _buildVideoForm()
                    else if (controller.contentType == 'Artikel')
                      _buildArticleForm()
                    else
                      SizedBox(),
                    SizedBox(height: 40),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: controller.isProcessing
                            ? null
                            : () {
                                setState(() {
                                  controller.submitEducationContent(
                                      context,
                                      controller
                                          .educationContent!['ID_Edukasi']);
                                });
                              },
                        icon: controller.isProcessing
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : Icon(Icons.cloud_upload, color: Colors.white),
                        label: controller.isProcessing
                            ? Text('') // Kosongkan label saat proses
                            : Text(
                                'Unggah',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 59, 142, 110),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Fungsi untuk membangun form artikel
  Widget _buildArticleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Judul Artikel:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller.titleController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan judul konten...',
            hintStyle: TextStyle(fontSize: 14),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Judul konten tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        Text('Deskripsi Artikel:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller.descriptionController,
          textInputAction: TextInputAction.next,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan isi konten...',
            hintStyle: TextStyle(fontSize: 14),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Isi konten tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Fungsi untuk membangun form video
  Widget _buildVideoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Link Url Video:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller.videoUrlController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan link video...',
            hintStyle: TextStyle(fontSize: 14),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (controller.contentType == 'Video' &&
                (value == null || value.isEmpty)) {
              return 'Link video tidak boleh kosong';
            } else if (value != null &&
                !RegExp(
                  r'^(https?://)?(www\.)?(youtube\.com/watch\?v=|youtu\.be/)([a-zA-Z0-9_-]{11})',
                  caseSensitive: false,
                ).hasMatch(value)) {
              return 'Masukkan URL YouTube yang valid';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        Text('Judul Video:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller.titleController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan judul video...',
            hintStyle: TextStyle(fontSize: 14),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Judul video tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        Text('Deskripsi Video:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller.descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan deskripsi video...',
            hintStyle: TextStyle(fontSize: 14),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Deskripsi video tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
