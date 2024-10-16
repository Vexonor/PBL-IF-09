import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/laporan/tambah_laporan.dart';

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
          widthFactor: 3.75,
          child: Text(
            'Laporan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sedang Diproses',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDaftarLaporan('Laporan: Tempat Sampah Liar',
                      'Ada tempat sampah liar baru di samping lapangan sepak bola...'),
                  _buildDaftarLaporan('Laporan: Lainnya',
                      'Setelah acara pasar malam di VITB, sampah dari kegiatan tsb be...'),
                  _buildDaftarLaporan('Laporan: Tempat Sampah Liar',
                      'Di tepi jalan dekat arah SMAN 3 Batam, warga mulai membuang...'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sudah Selesai',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDaftarLaporan('Laporan: Kondisi TPS',
                      'TPS di Piayu mengalami kebocoran dan air limbah mengalir ke ja...'),
                  _buildDaftarLaporan('Laporan: Pengangkutan Sampah',
                      'Sampah di RW 03 blm diambil sejak minggu lalu. Sudah menum...'),
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
                style: GoogleFonts.poppins(
                  fontSize: 6,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/beranda');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/lokasi_tps');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/bank_sampah');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/akun');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Lokasi TPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Bank Sampah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarLaporan(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 245, 239),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
