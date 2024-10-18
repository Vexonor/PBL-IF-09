import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'dart:io';

class UpdateLaporan extends StatefulWidget {
  const UpdateLaporan({super.key});

  @override
  State<UpdateLaporan> createState() => _UpdateLaporanState();
}

class _UpdateLaporanState extends State<UpdateLaporan> {
  TextEditingController controller = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController coordinatController = TextEditingController();
  DateTime dateInput = DateTime.now();
  List<XFile> _imagesBefore = [];
  List<XFile> _imagesAfter = [];

  Future<void> _chooseImagesBefore() async {
    final ImagePicker _pickerBefore = ImagePicker();
    final List<XFile>? imagesBefore = await _pickerBefore.pickMultiImage();
    if (imagesBefore != null && imagesBefore.isNotEmpty) {
      setState(() {
        _imagesBefore.addAll(imagesBefore);
      });
    }
  }

  Future<void> _chooseImagesAfter() async {
    final ImagePicker _pickerAfter = ImagePicker();
    final List<XFile>? imagesAfter = await _pickerAfter.pickMultiImage();
    if (imagesAfter != null && imagesAfter.isNotEmpty) {
      setState(() {
        _imagesAfter.addAll(imagesAfter);
      });
    }
  }

  void _showImage(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  void _deleteImageBefore(String imagePath) {
    setState(() {
      _imagesBefore.removeWhere((image) => image.path == imagePath);
    });
  }

  void _deleteImageAfter(String imagePath) {
    setState(() {
      _imagesAfter.removeWhere((image) => image.path == imagePath);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateInput,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (picked != null && picked != dateInput) {
      setState(() {
        dateInput = picked;
        controller.text =
            "${dateInput.day}/${dateInput.month}/${dateInput.year}";
      });
    }
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
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Title(
                  color: Colors.black,
                  child: Text(
                    "Update Laporan",
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
                        padding: EdgeInsets.only(left: 6),
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
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 130,
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
                                      child: Text(
                                        "Laporan : Tempat Sampah Liar",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  width: 100,
                                  child: Text(
                                    "17-09-2024",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            InputField(
                inputName: "Tanggal Menyelesaikan Laporan",
                icon: true,
                controllerName: controller,
                onTap: () {}),
            InputField(
                inputName: "Catatan ( Opsional )",
                icon: false,
                controllerName: textController,
                onTap: () {}),
            InputField(
                inputName: "Titik Koordinat",
                icon: false,
                controllerName: coordinatController,
                onTap: () {}),
            ImageUploadField(
              title: "Foto Sebelum DIkerjakan",
              images: _imagesBefore,
              onUpload: _chooseImagesBefore,
              onDelete: _deleteImageBefore,
              onShowImage: _showImage,
            ),
            ImageUploadField(
              title: "Foto Sesudah DIkerjakan",
              images: _imagesAfter,
              onUpload: _chooseImagesAfter,
              onDelete: _deleteImageAfter,
              onShowImage: _showImage,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 59, 142, 110),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {
              ElegantNotification.success(
                width: 350,
                animation: AnimationType.fromTop,
                title: Text(
                  "Informasi",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                description: Text(
                  "Laporan telah diselesaikan",
                  style: GoogleFonts.poppins(),
                ),
              ).show(context);

              Future.delayed(Duration(seconds: 0), () {
                Navigator.pop(context);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FeatherIcons.check,
                  color: Colors.white,
                  size: 20,
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Text(
                  "Selesaikan Laporan",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            )),
      ),
    );
  }

  Widget InputField({
    required String inputName,
    required bool icon,
    required TextEditingController controllerName,
    required VoidCallback onTap,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              inputName,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              cursorColor: Color.fromARGB(255, 59, 142, 110),
              ignorePointers: false,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 59, 142, 110), width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 241, 89, 80), width: 2)),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  suffixIcon: icon
                      ? IconButton(
                          onPressed: () {
                            _selectDate(context);
                            ;
                          },
                          icon: Icon(FeatherIcons.calendar))
                      : null),
              onChanged: (value) {
                setState(() {});
              },
              controller: controllerName,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageUploadField extends StatelessWidget {
  final String title;
  final List<XFile> images;
  final VoidCallback onUpload;
  final Function(String) onDelete;
  final Function(String) onShowImage;

  const ImageUploadField({
    Key? key,
    required this.title,
    required this.images,
    required this.onUpload,
    required this.onDelete,
    required this.onShowImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 59, 142, 110),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: onUpload,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FeatherIcons.upload,
                    color: Colors.white,
                    size: 15,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    "Unggah Gambar",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                final image = images[index];
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => onShowImage(image.path),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.file(
                          File(image.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 5),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
                        onPressed: () => onDelete(image.path),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
