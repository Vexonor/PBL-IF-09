import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/detailLaporan.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Laporan extends StatelessWidget {
  const Laporan({super.key});

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
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Title(
                  color: Colors.black,
                  child: Text(
                    "Daftar Laporan Masuk",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800, fontSize: 18),
                  )),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailLaporan();
                      }));
                    },
                    child: buildCard(
                      icon: FontAwesomeIcons.fileLines,
                      title: "Laporan : Tempat Sampah Liar",
                      description:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                    ),
                  ),
                  buildCard(
                    icon: FontAwesomeIcons.fileLines,
                    title: "Laporan : Tempat Sampah Liar",
                    description:
                        "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                  ),
                  buildCard(
                    icon: FontAwesomeIcons.fileLines,
                    title: "Laporan : Tempat Sampah Liar",
                    description:
                        "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                  ),
                  buildCard(
                    icon: FontAwesomeIcons.fileLines,
                    title: "Laporan : Tempat Sampah Liar",
                    description:
                        "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                  ),
                  buildCard(
                    icon: FontAwesomeIcons.fileLines,
                    title: "Laporan : Tempat Sampah Liar",
                    description:
                        "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                  ),
                ],
              ),
            ))
          ],
        ));
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5)),
            Icon(
              icon,
              size: 25,
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Column(
              children: [
                Title(
                    color: Colors.black,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    )),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
