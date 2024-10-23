import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/lokasi_tps/detail_lokasi_tps.dart';
import 'package:trashify/pages/notifikasi.dart';

class LokasiTps extends StatefulWidget {
  const LokasiTps({super.key});

  @override
  State<LokasiTps> createState() => _LokasiTpsState();
}

class _LokasiTpsState extends State<LokasiTps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Center(
          widthFactor: 2.7,
          child: Text(
            'Lokasi TPS',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Notifikasi()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color.fromARGB(255, 59, 142, 110),
                    Color.fromARGB(255, 59, 142, 110),
                    Color.fromARGB(255, 59, 142, 110),
                    Color.fromARGB(255, 59, 142, 110),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                  ],
                )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    margin: const EdgeInsets.only(top: 7.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 59, 142, 110)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Kecamatan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buildTombolKecamatan('Batam Kota'),
                              _buildTombolKecamatan('Batu Aji'),
                              _buildTombolKecamatan('Batu Ampar'),
                              _buildTombolKecamatan('B. Padang'),
                              _buildTombolKecamatan('Bengkong'),
                              _buildTombolKecamatan('Bulang'),
                              _buildTombolKecamatan('Galang'),
                              _buildTombolKecamatan('Lubuk Baja'),
                              _buildTombolKecamatan('Nongsa'),
                              _buildTombolKecamatan('Sagulung'),
                              _buildTombolKecamatan('Sei Beduk'),
                              _buildTombolKecamatan('Sekupang'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTombolKecamatan(String kecamatan) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailLokasiTps(kecamatan: kecamatan),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        fixedSize: const Size.fromWidth(140),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        kecamatan,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
