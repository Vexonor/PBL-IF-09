import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tps extends StatefulWidget {
  const Tps({super.key});

  @override
  State<Tps> createState() => _TpsState();
}

class _TpsState extends State<Tps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Center(
          child: Text(
            'Lokasi TPS',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
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
            onPressed: () {
              // Aksi untuk notifikasi
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: const Color.fromARGB(255, 59, 142, 110),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintText: 'Cari Lokasi',
                          hintStyle: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {
                        // Aksi untuk filter
                      },
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/lokasi_tps.png',
                  ),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    margin: EdgeInsets.only(top: 7.0),
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Color.fromARGB(255, 59, 142, 110)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kecamatan',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
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
                              _buildKecamatanButton('Batam Kota'),
                              _buildKecamatanButton('Batu Aji'),
                              _buildKecamatanButton('Batu Ampar'),
                              _buildKecamatanButton('B. Padang'),
                              _buildKecamatanButton('Bengkong'),
                              _buildKecamatanButton('Bulang'),
                              _buildKecamatanButton('Galang'),
                              _buildKecamatanButton('Lubuk Baja'),
                              _buildKecamatanButton('Nongsa'),
                              _buildKecamatanButton('Sagulung'),
                              _buildKecamatanButton('Sei Beduk'),
                              _buildKecamatanButton('Sekupang'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 75),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Aksi untuk tombol Filter
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text('Filter', 
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 59, 142, 110),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/tps');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/bank');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/account');
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
  Widget _buildKecamatanButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // Aksi untuk memilih kecamatan
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(140),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(title, style: GoogleFonts.poppins()),
    );
  }
}