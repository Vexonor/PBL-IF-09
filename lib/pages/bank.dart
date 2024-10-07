import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Center(
          child: Text(
            'Bank Sampah',
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
            Icons.account_balance,
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
                child: Column(
                  children: [
                    Text('Jenis Sampah',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
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
                  ],
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
        currentIndex: 2,
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
        fixedSize: Size.fromWidth(125),
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(title, style: GoogleFonts.poppins()),
    );
  }
}
