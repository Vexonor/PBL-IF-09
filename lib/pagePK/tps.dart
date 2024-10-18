import 'package:flutter/material.dart';
import 'package:flutter_learn/pagePK/notifikasi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class TPS extends StatefulWidget {
  const TPS({super.key});

  @override
  State<TPS> createState() => _TPSState();
}

class _TPSState extends State<TPS> {
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

  String formatTanggal(DateTime date) {
    return DateFormat('d MMMM y', 'id_ID').format(date);
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

  final List<DateTime> selectedDays = [
    DateTime(2024, 10, 11),
    DateTime(2024, 10, 13),
    DateTime(2024, 10, 15),
  ];

  DateTime? selectedDay;

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
            "Manajemen TPS",
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
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Title(
                color: Colors.black,
                child: Text(
                  "Jadwal Pengangkutan TPS",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 18),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              color: Colors.white,
              child: TableCalendar(
                locale: 'id_ID',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) {
                  return selectedDays
                      .any((selectedDate) => isSameDay(selectedDate, day));
                },
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.poppins(fontSize: 20),
                  formatButtonVisible: false,
                ),
                calendarStyle: CalendarStyle(
                    defaultTextStyle: GoogleFonts.poppins(),
                    weekendTextStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    selectedTextStyle: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    selectedDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 59, 142, 110),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 181, 255, 206),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: GoogleFonts.poppins(color: Colors.black)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 59, 142, 110),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )),
                  child: Center(
                    child: Text(
                      "Tanggal Pengangkutan",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 250,
                  child: Container(
                    height: 100,
                    child: Expanded(
                        child: ListView(
                      children: <Widget>[
                        CardPengangkutan(
                            date: "11",
                            tpsCode: "1",
                            city: "Batam Center",
                            status: "Selesai",
                            bgColor: successBgColor,
                            color: successColor,
                            button: true,
                            onClick: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: 1.0,
                                    minChildSize:
                                        0.5, // Ubah ini jika ingin mengubah ukuran minimal
                                    maxChildSize: 1.0,
                                    builder: (BuildContext context,
                                        ScrollController scrollController) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Text(
                                                "Update Status Pengangkutan TPS",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView(
                                                controller: scrollController,
                                                children: <Widget>[
                                                  const SizedBox(height: 20),
                                                  CardPengangkutan(
                                                      date: "11",
                                                      tpsCode: "1",
                                                      city: "Batam Center",
                                                      status: "Selesai",
                                                      bgColor: successBgColor,
                                                      color: successColor,
                                                      onClick: () {},
                                                      button: false),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        InputField(
                                                          inputName:
                                                              "Tanggal Menyelesaikan Laporan",
                                                          icon: true,
                                                          controllerName:
                                                              controller,
                                                          onTap: () {},
                                                        ),
                                                        InputField(
                                                          inputName:
                                                              "Catatan ( Opsional )",
                                                          icon: false,
                                                          controllerName:
                                                              textController,
                                                          onTap: () {},
                                                        ),
                                                        ImageUploadField(
                                                          title:
                                                              "Foto Sebelum DIkerjakan",
                                                          images: _imagesBefore,
                                                          onUpload:
                                                              _chooseImagesBefore,
                                                          onDelete:
                                                              _deleteImageBefore,
                                                          onShowImage:
                                                              _showImage,
                                                        ),
                                                        ImageUploadField(
                                                          title:
                                                              "Foto Sesudah DIkerjakan",
                                                          images: _imagesAfter,
                                                          onUpload:
                                                              _chooseImagesAfter,
                                                          onDelete:
                                                              _deleteImageAfter,
                                                          onShowImage:
                                                              _showImage,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 20),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 59, 142, 110),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  ElegantNotification.success(
                                                    width: 350,
                                                    animation:
                                                        AnimationType.fromTop,
                                                    title: Text(
                                                      "Informasi",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    description: Text(
                                                      "Jadwal Pengangkutan TPS Telah Diupdate",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    ),
                                                  ).show(context);

                                                  Future.delayed(
                                                      Duration(seconds: 0), () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FeatherIcons.check,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10)),
                                                    Text(
                                                      "Selesaikan Laporan",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }),
                        CardPengangkutan(
                            date: "13",
                            tpsCode: "2",
                            city: "Batu Aji",
                            status: "Belum Selesai",
                            bgColor: failBgColor,
                            color: failColor,
                            button: false,
                            onClick: () {}),
                        CardPengangkutan(
                            date: "15",
                            tpsCode: "3",
                            city: "Batu Ampar",
                            status: "Tertunda",
                            bgColor: delayBgColor,
                            color: delayColor,
                            button: false,
                            onClick: () {}),
                      ],
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget CardPengangkutan({
    required String date,
    required String tpsCode,
    required String city,
    required String status,
    required Color bgColor,
    required Color color,
    required VoidCallback onClick,
    required bool button,
  }) {
    return Card(
        color: Color.fromARGB(255, 245, 245, 245),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(5)),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 59, 142, 110),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Center(
                  child: Text(
                date,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "TPS-" + tpsCode,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    city,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, bottom: 8, top: 3),
                  width: 90,
                  height: 20,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: color, width: 1.5, style: BorderStyle.solid),
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
                ),
              ],
            ),
            Spacer(),
            button
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: onClick,
                      child: Icon(
                        FeatherIcons.checkSquare,
                        color: Colors.white,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 59, 142, 110),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ));
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
