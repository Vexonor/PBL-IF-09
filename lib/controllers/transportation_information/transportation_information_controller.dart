import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/pages/transportation_information/transportation_area.dart';
import 'package:trashify/services/transportation_information_service.dart';

class TransportationInformationController {
  final TransportationInformationService service =
      TransportationInformationService();
  Map<DateTime, Map<String, String>> detailInformation = {};
  List<dynamic> transportationInformation = [];
  Map<String, List<DateTime>> transportationSchedule = {};
  String? selectedDistrict;
  bool isCalendarVisible = false;
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [];
  String transportationTime = '00:00';
  bool isDistrictChanged = false;
  bool isLoading = true;

  Future<void> fetchTransportationInformation(
      BuildContext context, Function updateState) async {
    updateState(() {
      isLoading = true;
    });

    try {
      final response = await service.getTransportationInformation();

      if (response.statusCode == 200) {
        final List<dynamic> allInformasiPengangkutan =
            json.decode(response.body);
        transportationInformation = allInformasiPengangkutan.toList();
        _processTransportSchedule();
        _processDetailInformation();
      } else {
        if (context.mounted) {
          showSnackBar(
              context,
              'Gagal memuat Informasi Pengangkutan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62),
              2000);
        } // Menangani kesalahan jika respons tidak berhasil
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani kesalahan umum
    } finally {
      if (context.mounted) {
        updateState(() {
          isLoading = false;
        });
      }
    }
  }

  void _processTransportSchedule() {
    transportationSchedule.clear();
    for (var item in transportationInformation) {
      String district = item['Wilayah_Pengangkutan'];
      DateTime date = DateTime.parse(item['Tanggal_Pengangkutan']);

      if (date.isAfter(DateTime.now())) {
        if (!transportationSchedule.containsKey(district)) {
          transportationSchedule[district] = [];
        }
        transportationSchedule[district]!.add(date);
      }
    }
  }

  void _processDetailInformation() {
    detailInformation.clear();
    for (var item in transportationInformation) {
      DateTime date = DateTime.parse(item['Tanggal_Pengangkutan']);
      detailInformation[date] = {
        'status': item['Status_Pengangkutan'],
        'jam': item['Jam_Pengangkutan'],
        'wilayah': item['Wilayah_Pengangkutan'],
        'koordinat': item['Titik_Koordinat'],
        'id_petugas': item['ID_Petugas'],
      };
      transportationTime = item['Jam_Pengangkutan'];
    }
  }

  void showSlider(BuildContext context) {
    Map<String, String>? detail = detailInformation[selectedDate];
    String status = detail?['status'] ?? 'Tidak Diketahui';
    IconData statusIcon;

    if (status == 'Selesai') {
      statusIcon = Icons.check; // Icon centang
    } else if (status == 'Belum Selesai') {
      statusIcon = Icons.close; // Icon silang
    } else if (status == 'Tertunda') {
      statusIcon = Icons.hourglass_empty; // Icon jam pasir
    } else {
      statusIcon = Icons.help; // Icon untuk status tidak diketahui
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 5, indent: 150, endIndent: 150),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 59, 142, 110),
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child: Text('Detail Informasi',
                          style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              Map<String, String>? detail =
                                  detailInformation[selectedDate];
                              String coordinatesString =
                                  detail?['koordinat'] ?? '0,0';
                              List<String> latLng =
                                  coordinatesString.split(',');
                              LatLng coordinates = LatLng(
                                  double.parse(latLng[0]),
                                  double.parse(latLng[1]));
                              String idPetugas =
                                  detail?['id_petugas'] ?? 'Tidak Diketahui';

                              return TransportationArea(
                                selectedDate: selectedDate,
                                transportationTime: transportationTime,
                                coordinates: coordinates,
                                idWorker: idPetugas,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Maps',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInformation(
                        'Tanggal Pengangkutan',
                        DateFormat('dd - MM - yyyy').format(selectedDate),
                        Icons.calendar_today,
                      ),
                      _buildInformation(
                        'Status Pengangkutan',
                        status,
                        statusIcon,
                      ),
                      _buildInformation(
                        'Jam Pengangkutan',
                        detail?['jam'] ?? 'Tidak Diketahui',
                        Icons.access_time,
                      ),
                      _buildInformation(
                        'Wilayah Pengangkutan',
                        detail?['wilayah'] ?? 'Tidak Diketahui',
                        Icons.location_on,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInformation(String label, String isi, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color.fromARGB(255, 59, 142, 110)),
              SizedBox(width: 10),
              Text(
                '$label: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 4),
          Flexible(
            fit: FlexFit.loose,
            child: Text(isi),
          ),
        ],
      ),
    );
  }

  Widget buildAlert() {
    if (selectedDistrict == null || selectedDistrict!.isEmpty) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Text('Harap pilih salah satu wilayah kecamatan',
              style: TextStyle(color: const Color.fromARGB(255, 181, 61, 62))),
        ),
      );
    } else if (markedDates.isEmpty) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Text('Jadwal Kosong',
              style: TextStyle(color: const Color.fromARGB(255, 181, 61, 62))),
        ),
      );
    } else {
      return Container(); // Or any other widget you want to show
    }
  }

  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        // Mendapatkan tinggi keyboard
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 20.0 +
              keyboardHeight, // Jarak dari bawah ditambah tinggi keyboard
          left: 0,
          right: 0,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(milliseconds: time), () {
      overlayEntry.remove();
    });
  }
}
