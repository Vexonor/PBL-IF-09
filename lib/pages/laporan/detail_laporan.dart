import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/laporan/edit_laporan.dart';

class DetailLaporan extends StatefulWidget {
  final String kategori;
  final String deskripsi;
  final String koordinat;
  final String gambar;
  const DetailLaporan(
      {super.key,
      required this.kategori,
      required this.deskripsi,
      required this.koordinat,
      required this.gambar});

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  void _tampilkanModalHapus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Konfirmasi Penghapusan',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus laporan ini?',
            style: TextStyle(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Ya',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
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
          widthFactor: 2.0,
          child: Text(
            'Detail Laporan',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJudulBagian('Kategori Laporan'),
            const SizedBox(height: 8),
            _buildIsiBagian(widget.kategori),
            const SizedBox(height: 16),
            _buildJudulBagian('Deskripsi Laporan'),
            const SizedBox(height: 8),
            _buildIsiBagian(widget.deskripsi),
            const SizedBox(height: 16),
            _buildJudulBagian('Titik Koordinat'),
            const SizedBox(height: 8),
            _buildIsiBagian(widget.koordinat),
            const SizedBox(height: 14),
            _buildJudulBagian('Gambar'),
            const SizedBox(height: 8),
            Container(
              height: 200,
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
                  image: AssetImage(
                    widget.gambar,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditLaporan(
                          kategori: widget.kategori,
                          deskripsi: widget.deskripsi,
                          koordinat: widget.koordinat,
                          gambar: widget.gambar,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: Text('Edit',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _tampilkanModalHapus();
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: Text('Hapus',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJudulBagian(String judul) {
    return Text(
      judul,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildIsiBagian(String isi) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isi,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
