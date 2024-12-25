import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/pages/notification.dart';
import 'package:trashify/pages/settings/setting.dart';
import 'package:trashify/services/global_url.dart';

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userPhoto = Provider.of<UserProvider>(context).userPhoto;
    final userName = Provider.of<UserProvider>(context).userName;
    final userEmail = Provider.of<UserProvider>(context).userEmail;
    final userNumber = Provider.of<UserProvider>(context).userNumber;
    final userAddress = Provider.of<UserProvider>(context).userAddress;
    final userDateBirth = Provider.of<UserProvider>(context).userDateBirth;
    final userGender = Provider.of<UserProvider>(context).userGender;
    final userNik = Provider.of<UserProvider>(context).userNik;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Text(
          'Trashify',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
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
                MaterialPageRoute(
                    builder: (context) => const NotificationCenter()),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 59, 142, 110),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: userPhoto != null
                        ? CachedNetworkImageProvider(
                            '$imageStorageUrl/$userPhoto')
                        : null,
                    child: userPhoto == null
                        ? Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$userName',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Setting()),
                      );
                    },
                    icon: const Icon(Icons.settings,
                        size: 20, color: Colors.black),
                    label: const Text('Pengaturan',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    _buildProfilPengguna(Icons.email, 'Email', '$userEmail'),
                    _buildProfilPengguna(Icons.credit_card, 'NIK', '$userNik'),
                    _buildProfilPengguna(
                        Icons.phone, 'No. Telepon', '$userNumber'),
                    _buildProfilPengguna(Icons.home, 'Alamat', '$userAddress'),
                    _buildProfilPengguna(
                        Icons.calendar_month, 'Tanggal Lahir', '$userDateBirth'),
                    _buildProfilPengguna(
                        Icons.wc, 'Jenis Kelamin', '$userGender'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilPengguna(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[700]),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
