import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TambahEdukasi extends StatefulWidget {
  const TambahEdukasi({super.key});

  @override
  State<TambahEdukasi> createState() => _TambahEdukasiState();
}

class _TambahEdukasiState extends State<TambahEdukasi> {
  String _contentType = 'Dokumen';
  final _videoUrlController = TextEditingController();
  final _judulVideoController = TextEditingController();
  final _deskripsiVideoController = TextEditingController();
  final _judulArtikelController = TextEditingController();
  final _gambarArtikelController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _videoUrlController.dispose();
    _judulVideoController.dispose();
    _deskripsiVideoController.dispose();
    _judulArtikelController.dispose();
    _gambarArtikelController.dispose();
    super.dispose();
  }

  XFile? _gambarPilihan;
  final _pemilih = ImagePicker();

  void _pilihGambar() async {
    final gambarTerpilih =
        await _pemilih.pickImage(source: ImageSource.gallery);
    setState(() {
      _gambarPilihan = gambarTerpilih;
    });
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
        title: Center(
          widthFactor: 1.7,
          child: Text(
            'Tambah Edukasi',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jenis Konten:', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Radio(
                    value: 'Dokumen',
                    groupValue: _contentType,
                    onChanged: (String? value) {
                      setState(() {
                        _contentType = value!;
                      });
                    },
                  ),
                  Text('Dokumen', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 20),
                  Radio(
                    value: 'Video',
                    groupValue: _contentType,
                    onChanged: (String? value) {
                      setState(() {
                        _contentType = value!;
                      });
                    },
                  ),
                  Text('Video', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 20),
              if (_contentType == 'Video')
                _buildFormVideo()
              else if (_contentType == 'Dokumen')
                _buildFormDokumen()
              else
                SizedBox(),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Unggah',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormDokumen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Judul Konten:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: _judulArtikelController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan judul konten...',
              hintStyle: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 20),
        Text('Isi Konten:', style: TextStyle(fontSize: 16)),
        TextField(
          controller: _gambarArtikelController,
          textInputAction: TextInputAction.next,
          maxLines: 4,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan isi konten...',
              hintStyle: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 20),
        Text('Dokumen Pendukung:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _pilihGambar,
            icon: const Icon(
              Icons.file_upload,
              color: Colors.white,
            ),
            label: Text(
              'Tambah Dokumen (Opsional)',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 59, 142, 110),
            ),
          ),
        ),
        if (_gambarPilihan != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.file(
                File(_gambarPilihan!.path),
                height: 100,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFormVideo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Link Url Video:', style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: _videoUrlController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan link video...',
              hintStyle: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 20),
        Text('Judul Video:', style: TextStyle(fontSize: 16)),
        TextField(
          controller: _judulVideoController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan judul video...',
              hintStyle: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 20),
        Text('Deskripsi Video:', style: TextStyle(fontSize: 16)),
        TextField(
          controller: _deskripsiVideoController,
          maxLines: 5,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan deskripsi video...',
              hintStyle: TextStyle(fontSize: 14)),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
