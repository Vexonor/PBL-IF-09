import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:text_divider/text_divider.dart';
import 'dart:io';

class DetailRiwayat extends StatefulWidget {
  const DetailRiwayat({super.key});

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  Color successColor = Color.fromARGB(255, 59, 142, 110);
  Color successBgColor = Color.fromARGB(255, 181, 255, 206);

  Color delayColor = Color.fromARGB(255, 255, 153, 0);
  Color delayBgColor = Color.fromARGB(255, 255, 243, 174);

  Color failColor = Color.fromARGB(255, 241, 89, 80);
  Color failBgColor = Color.fromARGB(255, 238, 179, 176);

  TextEditingController controller = TextEditingController();
  TextEditingController textController = TextEditingController();

  void _showImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

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
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "Detail Laporan Masuk",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
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
                              backgroundColor:
                                  Color.fromARGB(255, 59, 142, 110),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/trash.png",
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    "17-09-2024",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          "Laporan : Tempat Sampah Liar",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
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
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Icon(FeatherIcons.mapPin),
                            SizedBox(width: 10),
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          child: Text(
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah."
                            "Ada tempat sampah liar baru di samping lapangan sepak bola di Jl. Raja Ali Haji..."
                            " Mohon segera ditindaklanjuti sebelum semakin parah.",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: TextDivider.horizontal(
                          text: Text(
                            'Riwayat Pengerjaan',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          color: Colors.black26,
                          thickness: 2.0,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          InputField(inputName: "Tanggal Penyelesaian Laporan"),
                          InputField(inputName: "Catatan ( Opsional )"),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Foto Sesudah Dikerjakan",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      ImageUploadField(
                        images: [
                          File("assets/images/trash.png"),
                          File("assets/images/trash.png"),
                          File("assets/images/trash.png"),
                          File("assets/images/trash.png"),
                          File("assets/images/trash.png"),
                          File("assets/images/trash.png"),
                        ],
                        onShowImage: _showImage,
                      ),
                      BadgeStatus(
                          status: "Selesai",
                          bgColor: successBgColor,
                          color: successColor)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget InputField({required String inputName}) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            inputName,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          TextField(
            cursorColor: Color.fromARGB(255, 59, 142, 110),
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 59, 142, 110), width: 2)),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            ),
          ),
        ],
      ),
    );
  }

  Widget BadgeStatus({
    required String status,
    required Color bgColor,
    required Color color,
  }) {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Container(
          width: 300,
          height: 40,
          margin: EdgeInsets.only(top: 10, bottom: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border:
                Border.all(color: color, width: 1.5, style: BorderStyle.solid),
          ),
          child: Center(
            child: Text(
              status,
              style: GoogleFonts.poppins(
                  color: color, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ));
  }
}

class ImageUploadField extends StatelessWidget {
  final List<File> images;
  final Function(String) onShowImage;

  const ImageUploadField({
    Key? key,
    required this.images,
    required this.onShowImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              final image = images[index];
              return GestureDetector(
                onTap: () => onShowImage(image.path),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.file(
                    image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
