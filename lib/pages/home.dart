import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userName;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  Future<void> getUserData() async {
    // Ambil user ID yang sedang login
    String uid = _auth.currentUser!.uid;

    // Ambil dokumen pengguna dari koleksi 'users'
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();

    // Jika dokumen ada, ambil nilai 'name'
    if (snapshot.exists) {
      setState(() {
        userName = snapshot.get('name');
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 54, 133, 102),
        title: Text(
          'Trashify',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, 
              fontSize: 20, 
              color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Handle notifications
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Greeting Section
            Container(
              height: 256,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/beranda_warga.png',
                  ),
                  fit: BoxFit.cover,
                )
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $userName!',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '(slogan aplikasi)',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Features Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Fitur',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Lapor Button
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // TODO: Navigate to Lapor
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(Icons.edit, size: 40, color: Color.fromARGB(255, 54, 133, 102)),
                              SizedBox(height: 10),
                              Text(
                                'Lapor',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Laporkan terkait masalah sampah, TPS, dan kebersihan di sekitar Anda.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  // Jadwal Button
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // TODO: Navigate to Jadwal
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 40, color: Color.fromARGB(255, 54, 133, 102)),
                              SizedBox(height: 10),
                              Text(
                                'Jadwal',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Lihat jadwal dan rute pengangkutan sampah di area Anda.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Education Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Edukasi',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Tabs for Video and Article
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Show videos
                      },
                      child: Text('Video'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Show articles
                      },
                      child: Text('Artikel'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to "Lihat Semua"
                    },
                    child: Text('Lihat Semua'),
                  )
                ],
              ),
            ),

            // Educational Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Langkah Sederhana Memilah Sampah di Rumah',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.thumb_up, size: 16),
                                Text('120'),
                                Icon(Icons.comment, size: 16),
                                Text('45'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Karya Daur Ulang Sampah Plastik',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.thumb_up, size: 16),
                                Text('75'),
                                Icon(Icons.comment, size: 16),
                                Text('56'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 54, 133, 102),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0, // Indeks halaman beranda
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
}
