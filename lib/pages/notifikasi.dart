import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  Icon inbox = const Icon(
    Icons.archive,
    size: 25,
  );
  Icon approved = const Icon(
    Icons.check,
    size: 25,
    color: Color.fromARGB(255, 59, 142, 110),
  );
  Icon declined = const Icon(
    Icons.close,
    size: 25,
    color: Color.fromARGB(255, 241, 89, 80),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          widthFactor: 3.0,
          child: Text(
            'Notifikasi',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      jenis: "Laporan Masuk",
                      deskripsi:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      tanggal: "9 April, 2024 Pukul 08.00",
                      icon: inbox),
                ),
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      jenis: "Laporan Diterima",
                      deskripsi:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      tanggal: "9 April, 2024 Pukul 08.00",
                      icon: approved),
                ),
                InkWell(
                  onTap: () {},
                  child: buildCard(
                      jenis: "Laporan Ditolak",
                      deskripsi:
                          "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji. Sampah semakin menumpuk dan berserakan sampai ke jalan, serta kondisinya mulai menimbulkan bau tidak sedap. Mohon segera ditindaklanjuti sebelum semakin parah.",
                      tanggal: "9 April, 2024 Pukul 08.00",
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
    required String jenis,
    required String deskripsi,
    required String tanggal,
    required Icon icon,
  }) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
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
                      jenis,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                Container(
                  width: 250,
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    deskripsi,
                    style: TextStyle(
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
                    tanggal,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(5)),
            icon
          ],
        ),
      ),
    );
  }
}
