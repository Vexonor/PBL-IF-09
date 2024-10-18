import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/jadwal.dart';
import 'package:flutter_learn/pagePK/laporan.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:flutter_learn/pagePK/riwayat.dart';
import 'package:flutter_learn/pagePK/tps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_divider/text_divider.dart';

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Text(
          "Trashify",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Notifikasi();
              }));
            },
            icon: const Icon(FontAwesomeIcons.bell),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              height: 220,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 59, 142, 110),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 59, 142, 110),
                  Color.fromARGB(50, 59, 142, 110)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Title(
                    color: Colors.white,
                    child: Text(
                      "Hi, Pengguna",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Slogan Disini",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 300,
                      margin: const EdgeInsets.only(right: 5),
                      child: Image.asset("assets/images/main-bg.png"),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  TextDivider.horizontal(
                    text: Text(
                      'Fitur',
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.black26,
                    thickness: 2.0,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Laporan();
                            }));
                          },
                          child: buildCard(
                            icon: FontAwesomeIcons.clipboard,
                            title: "Laporan",
                            description:
                                "Laporan terkait masalah sampah, TPS, dan kebersihan di sekitar Anda.",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Riwayat();
                            }));
                          },
                          child: buildCard(
                            icon: FontAwesomeIcons.clockRotateLeft,
                            title: "Riwayat Laporan",
                            description:
                                "Lihat riwayat laporan yang telah Anda tindaklanjuti.",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Jadwal();
                            }));
                          },
                          child: buildCard(
                            icon: FontAwesomeIcons.calendarDays,
                            title: "Jadwal",
                            description:
                                "Lihat jadwal dan rute pengangkutan sampah di area Anda.",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TPS();
                            }));
                          },
                          child: buildCard(
                            icon: FontAwesomeIcons.trashArrowUp,
                            title: "Manajemen TPS",
                            description:
                                "Lihat lokasi tempat pembuangan sementara di area Anda.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.white70,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 5)),
            Icon(
              icon,
              size: 25,
            ),
            Title(
              color: Colors.black,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                description,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                FontAwesomeIcons.arrowRight,
                size: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
