import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/lokasi_tps/detail_lokasi_tps.dart';

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
          widthFactor: 2.75,
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
            // TODO: Halaman Notifikasi
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
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
                            style: GoogleFonts.poppins(
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
                        const SizedBox(height: 75),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 59, 142, 110),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Filter',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 1,
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

  Widget _buildTombolKecamatan(String title) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailLokasiTps(kecamatan: title),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(140),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(title, style: GoogleFonts.poppins()),
    );
  }
}
