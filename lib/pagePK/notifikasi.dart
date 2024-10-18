import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  Icon inbox = Icon(
    FeatherIcons.archive,
    size: 20,
  );
  Icon approved = Icon(
    FeatherIcons.checkCircle,
    size: 25,
    color: Color.fromARGB(255, 59, 142, 110),
  );
  Icon declined = Icon(
    FeatherIcons.xCircle,
    size: 25,
    color: Color.fromARGB(255, 241, 89, 80),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        title: Text(
          "Notifikasi",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
              child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      title: "Laporan Masuk",
                      description:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      dateTime: "9 April, 2024 Pukul 08.00",
                      icon: inbox),
                ),
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      title: "Laporan Diterima",
                      description:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      dateTime: "9 April, 2024 Pukul 08.00",
                      icon: approved),
                ),
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      title: "Laporan Ditolak",
                      description:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      dateTime: "9 April, 2024 Pukul 08.00",
                      icon: declined),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget buildCard({
    required String title,
    required String description,
    required String dateTime,
    required Icon icon,
  }) {
    return Card(
      color: Color.fromARGB(255, 245, 245, 245),
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Title(
                    color: Colors.black,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                    )),
                Container(
                  width: 250,
                  padding: const EdgeInsets.only(top: 5),
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
                Container(
                  width: 250,
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    dateTime,
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
            Padding(padding: EdgeInsets.all(5)),
            icon
          ],
        ),
      ),
    );
  }
}
