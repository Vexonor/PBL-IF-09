import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/pages/laporan/fungsi_tambahan/pilih_koordinat.dart';

class EditLaporan extends StatefulWidget {
  final String kategori;
  final String deskripsi;
  final String koordinat;
  final String gambar;
  const EditLaporan(
      {super.key,
      required this.kategori,
      required this.deskripsi,
      required this.koordinat,
      required this.gambar});

  @override
  State<EditLaporan> createState() => _EditLaporanState();
}

class _EditLaporanState extends State<EditLaporan> {
  late TextEditingController _deskripsiLaporanController;
  late TextEditingController _koordinatController;

  final _formkey = GlobalKey<FormState>();

  // ignore: unused_field
  LatLng? _koordinatPilihan;

  Future<void> _bukaMap() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Pilihkoordinat(),
      ),
    );

    if (result != null) {
      setState(() {
        _koordinatPilihan = result;
        _koordinatController.text = '${result.latitude}, ${result.longitude}';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _deskripsiLaporanController = TextEditingController(text: widget.deskripsi);
    _koordinatController = TextEditingController(text: widget.koordinat);
    _kategoriLaporan = widget.kategori;
  }

  @override
  void dispose() {
    _deskripsiLaporanController.dispose();
    _koordinatController.dispose();
    super.dispose();
  }

  String? _kategoriLaporan;
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
          widthFactor: 2.3,
          child: Text(
            'Edit Laporan',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Melaporkan terkait:',
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
                Text('Deskripsi Laporan:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _deskripsiLaporanController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Ketikan keluhan Anda di sini',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Titik Koordinat:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _koordinatController,
                  readOnly: true,
                  onTap: _bukaMap,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Ketuk untuk memilih koordinat dari map',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      suffixIcon: const SizedBox(
                        child: Icon(Icons.map),
                      )),
                ),
                const SizedBox(height: 20),
                Text('Dokumen Pendukung:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
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
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Kirim',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                  ),
                ),
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
      groupValue: _kategoriLaporan,
      onChanged: (String? value) {
        setState(() {
          _kategoriLaporan = value;
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
