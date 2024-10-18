import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:flutter_learn/pagePK/updateLaporan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailLaporan extends StatelessWidget {
  const DetailLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Center(
          child: Text(
            "Laporan",
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
                  "Detail Laporan Masuk",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 18),
                )),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
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
                                "assets/images/trash.png",
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
                                width: 150,
                                child: Title(
                                    color: Colors.black,
                                    child: Text(
                                      "Username",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    )),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                width: 130,
                                child: Text(
                                  "17-09-2024",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  Center(
                    child: Container(
                      child: Title(
                          color: Colors.black,
                          child: Text(
                            "Laporan : Tempat Sampah Liar",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/trash.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Icon(FeatherIcons.mapPin),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "-7.8953785, 542.8593966",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 150,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Text(
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah. Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah. Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah. Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah. Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah. Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.  ",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w400),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 59, 142, 110),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return UpdateLaporan();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FeatherIcons.checkSquare,
                              color: Colors.white,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              "Update Laporan",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
