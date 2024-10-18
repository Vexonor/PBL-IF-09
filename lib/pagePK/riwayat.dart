import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/detailRiwayat.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  Color successColor = Color.fromARGB(255, 59, 142, 110);
  Color successBgColor = Color.fromARGB(255, 181, 255, 206);

  Color delayColor = Color.fromARGB(255, 255, 153, 0);
  Color delayBgColor = Color.fromARGB(255, 255, 243, 174);

  Color failColor = Color.fromARGB(255, 241, 89, 80);
  Color failBgColor = Color.fromARGB(255, 238, 179, 176);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Center(
          child: Text(
            "Riwayat Laporan",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Title(
                color: Colors.black,
                child: Text(
                  "Riwayat Pengerjaan Laporan",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 18),
                )),
          ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Expanded(
                  child: Column(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailRiwayat();
                        }));
                      },
                      child: CardRiwayatLaporan(
                          userProfile: "assets/images/trash.png",
                          username: "Pengguna1",
                          description: "Tempat Sampah Liar",
                          date: "20-09-2024",
                          status: "Selesai",
                          bgColor: successBgColor,
                          color: successColor)),
                  InkWell(
                      onTap: () {},
                      child: CardRiwayatLaporan(
                          userProfile: "assets/images/trash.png",
                          username: "Pengguna1",
                          description: "Tempat Sampah Liar",
                          date: "20-09-2024",
                          status: "Tidak Selesai",
                          bgColor: failBgColor,
                          color: failColor)),
                ],
              )))
        ],
      ),
    );
  }

  Widget CardRiwayatLaporan({
    required String userProfile,
    required String username,
    required String description,
    required String date,
    required String status,
    required Color bgColor,
    required Color color,
  }) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 59, 142, 110),
                    child: ClipOval(
                      child: Image.asset(
                        userProfile,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Title(
                                  color: Colors.black,
                                  child: Text(
                                    username,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  )),
                              Text(
                                "Laporan : " + description,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                              ),
                              Text(
                                "Tanggal Penyelesaian : " + date,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: 100,
                          child: Container(
                            width: 90,
                            height: 20,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: color,
                                  width: 1.5,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 5)),
                                Icon(
                                  FontAwesomeIcons.solidCircle,
                                  size: 7,
                                  color: color,
                                ),
                                Text(
                                  status,
                                  style: GoogleFonts.poppins(
                                      color: color,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
