import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trashify/pages/informasi_pengangkutan/lokasi_pengangkutan.dart';
import 'package:trashify/pages/notifikasi.dart';

class InformasiPengangkutan extends StatefulWidget {
  const InformasiPengangkutan({super.key});

  @override
  State<InformasiPengangkutan> createState() => _InformasiPengangkutanState();
}

class _InformasiPengangkutanState extends State<InformasiPengangkutan> {
  String? selectedDistrict;
  bool isCalendarVisible = false;
  DateTime selectedDate = DateTime.now();
  String jamPengangkutan = '12:00 - 16:00';
  List<DateTime> markedDates = [
    DateTime(2024, 9, 2),
    DateTime(2024, 9, 11),
    DateTime(2024, 9, 20),
  ];

  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = markedDates.isNotEmpty ? markedDates.first : DateTime.now();
  }

  void _tampilkanSlider(BuildContext context) {
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
                SizedBox(height: 10),
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
                            builder: (context) => LokasiPengangkutan(
                                selectedDate: selectedDate,
                                jamPengangkutan: jamPengangkutan),
                          ),
                        );
                      },
                      child: Text('Maps'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBarisInformasi(
                        'Tanggal Pengangkutan',
                        DateFormat('dd - MM - yyyy').format(selectedDate),
                        Icons.calendar_today,
                      ),
                      _buildBarisInformasi(
                        'Status Pengangkutan',
                        'Terkonfirmasi',
                        Icons.check,
                      ),
                      _buildBarisInformasi(
                        'Jam Pengangkutan',
                        '12.00 - 16.00',
                        Icons.access_time,
                      ),
                      _buildBarisInformasi(
                        'Wilayah Pengangkutan',
                        'Kel. Belian - Kel. Teluk Tering',
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
          widthFactor: 3.4,
          child: Text(
            'Informasi Pengangkutan',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifikasi()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedDistrict,
              hint: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text('Pilih Kecamatan'),
                ],
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              items: ['Kecamatan 1', 'Kecamatan 2', 'Kecamatan 3']
                  .map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedDistrict != null) {
                  setState(() {
                    isCalendarVisible = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 5
              ),
              child: Text(
                'Lihat Jadwal',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            if (isCalendarVisible)
              CalendarDatePicker(
                initialDate:
                    markedDates.isNotEmpty ? markedDates.first : DateTime.now(),
                firstDate: DateTime(2020, 1, 1),
                lastDate: DateTime(2025, 12, 31),
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                  if (markedDates.contains(date)) {
                    _tampilkanSlider(context);
                  }
                },
                selectableDayPredicate: (date) {
                  return markedDates.contains(date);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarisInformasi(String label, String isi, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green),
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
}
