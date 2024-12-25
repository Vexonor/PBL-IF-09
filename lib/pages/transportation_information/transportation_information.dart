import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/transportation_information/transportation_information_controller.dart';

class TransportationInformation extends StatefulWidget {
  const TransportationInformation({super.key});

  @override
  State<TransportationInformation> createState() =>
      _TransportationInformationState();
}

class _TransportationInformationState extends State<TransportationInformation> {
  final TransportationInformationController controller =
      TransportationInformationController();

  @override
  void initState() {
    super.initState();
    controller.fetchTransportationInformation(context, setState);
  }

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Informasi Pengangkutan',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/notifikasi');
              },
            )
          ],
        ),
        body: Stack(children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BackgroundPainter(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.isLoading
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20.0),
                          child: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 10),
                              Text(
                                'Memuat...',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      : PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              controller.selectedDistrict = value;
                              controller.isDistrictChanged = true;

                              // Update markedDates based on the selected district
                              controller.markedDates =
                                  controller.transportationSchedule[
                                          controller.selectedDistrict] ??
                                      [];
                              controller.isCalendarVisible =
                                  false; // Reset calendar visibility
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              'Batu Ampar',
                              'Bengkong',
                              'Bulang',
                              'Galang',
                              'Lubuk Baja',
                              'Nongsa',
                              'Sagulung',
                              'Sei Beduk',
                              'Sekupang',
                              'Batam Kota',
                              'Belakang Padang',
                              'Batu Aji'
                            ].map((String district) {
                              return PopupMenuItem<String>(
                                value: district,
                                child: Text(district),
                              );
                            }).toList();
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Ubah radius sesuai kebutuhan
                          ),
                          constraints: BoxConstraints(
                            minWidth:
                                500, // Atur lebar minimum sesuai kebutuhan
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 10),
                                Text(
                                  controller.selectedDistrict ??
                                      'Pilih Wilayah',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 16),
                  if (controller.markedDates
                      .isNotEmpty) // Menampilkan tombol hanya jika ada jadwal
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.isCalendarVisible =
                              true; // Tampilkan kalender
                          controller.isDistrictChanged =
                              false; // Reset flag setelah menekan tombol
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Warna latar belakang saat aktif
                        elevation: 5,
                      ),
                      child: Text(
                        'Lihat Jadwal',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  SizedBox(height: 10),
                  controller.buildAlert(),
                  if (controller.isCalendarVisible &&
                      controller.markedDates.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: CalendarDatePicker(
                            initialDate: controller.markedDates.isNotEmpty
                                ? controller.markedDates.first
                                : DateTime.now(),
                            firstDate: DateTime(2020, 1, 1),
                            lastDate: DateTime(2025, 12, 31),
                            onDateChanged: (date) {
                              setState(() {
                                controller.selectedDate = date;
                              });
                              if (controller.markedDates.contains(date)) {
                                controller.showSlider(context);
                              }
                            },
                            selectableDayPredicate: (date) {
                              return controller.markedDates.contains(date);
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ]));
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGreen = Paint()..color = Color.fromARGB(255, 59, 142, 110);
    final paintWhite = Paint()..color = Colors.white;

    // Menggambar segitiga putih di kiri
    final pathWhite = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    // Menggambar segitiga hijau di kanan dengan tinggi setengah layar
    final pathGreen = Path()
      ..lineTo(size.width, 0) // Titik atas kanan
      ..lineTo(size.width, size.height) // Titik tengah kanan
      ..lineTo(size.width, size.height / 2) // Titik bawah tengah
      ..close();

    canvas.drawPath(pathWhite, paintWhite);
    canvas.drawPath(pathGreen, paintGreen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
