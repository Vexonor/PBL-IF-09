import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/laporan/detail_laporan.dart';
import 'package:trashify/pages/laporan/tambah_laporan.dart';
import 'package:trashify/pages/notifikasi.dart';

class Laporan extends StatefulWidget {
  const Laporan({super.key});

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
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
          widthFactor: 3.4,
          child: Text(
            'Laporan',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifikasi()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sedang Diproses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDaftarLaporan(
                      'Tempat Sampah Liar',
                      'Ada tempat sampah liar baru di samping lapangan sepak bola...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh1.png'),
                  _buildDaftarLaporan(
                      'Lainnya',
                      'Setelah acara pasar malam di VITB, sampah dari kegiatan tsb be...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh2.png'),
                  _buildDaftarLaporan(
                      'Tempat Sampah Liar',
                      'Di tepi jalan dekat arah SMAN 3 Batam, warga mulai membuang...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh1.png'),
                  _buildDaftarLaporan(
                      'Lainnya',
                      'Setelah acara pasar malam di VITB, sampah dari kegiatan tsb be...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh2.png'),
                  _buildDaftarLaporan(
                      'Tempat Sampah Liar',
                      'Di tepi jalan dekat arah SMAN 3 Batam, warga mulai membuang...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh1.png'),
                  _buildDaftarLaporan(
                      'Lainnya',
                      'Setelah acara pasar malam di VITB, sampah dari kegiatan tsb be...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh2.png'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sudah Selesai',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDaftarLaporan(
                      'Kondisi TPS',
                      'TPS di Piayu mengalami kebocoran dan air limbah mengalir ke ja...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh3.png'),
                  _buildDaftarLaporan(
                      'Pengangkutan Sampah',
                      'Sampah di RW 03 blm diambil sejak minggu lalu. Sudah menum...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh4.png'),
                  _buildDaftarLaporan(
                      'Kondisi TPS',
                      'TPS di Piayu mengalami kebocoran dan air limbah mengalir ke ja...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh3.png'),
                  _buildDaftarLaporan(
                      'Pengangkutan Sampah',
                      'Sampah di RW 03 blm diambil sejak minggu lalu. Sudah menum...',
                      '1.0828, 104.0305',
                      'assets/images/laporan/contoh4.png'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahLaporan(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              const Icon(Icons.edit, color: Colors.white),
              Text(
                'Buat Laporan',
                style: TextStyle(
                  fontSize: 6,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaftarLaporan(
      String kategori, String deskripsi, String koordinat, String gambar) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(Icons.article, color: Colors.grey[700]),
        title: Text(
          'Laporan: $kategori',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          deskripsi,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailLaporan(
                kategori: kategori,
                deskripsi: deskripsi,
                koordinat: koordinat,
                gambar: gambar,
              ),
            ),
          );
        },
      ),
    );
  }
}
