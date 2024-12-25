import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/controllers/transportation_information/transportation_area_controller.dart';
import 'package:trashify/pages/complaint/complaint_add.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationArea extends StatefulWidget {
  final DateTime selectedDate;
  final String transportationTime;
  final LatLng coordinates;
  final String idWorker; // Menambahkan parameter

  const TransportationArea({
    super.key,
    required this.selectedDate,
    required this.transportationTime,
    required this.coordinates,
    required this.idWorker, // Menambahkan parameter
  });

  @override
  State<TransportationArea> createState() => _TransportationAreaState();
}

class _TransportationAreaState extends State<TransportationArea> {
  final MapController _mapController = MapController();
  final TransportationAreaController controller =
      TransportationAreaController();

  @override
  void initState() {
    super.initState();
    controller
        .fetchWorkerInformation(context, setState, widget.idWorker)
        .then((_) {
      // Tampilkan BottomSheet hanya jika data berhasil dimuat
      if (controller.name != null) {
        if (mounted) {
          showSlider(context);
        }
      }
    });
  }

  void showSlider(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height:
              MediaQuery.of(context).size.height * 1 / 3.3, // Tinggi 1/3 layar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
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
                        backgroundColor: Colors.white,
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Detail Informasi',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 59, 142, 110),
                        elevation: 2,
                      ),
                      onPressed: () {},
                      child:
                          Text('Maps', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Color.fromARGB(255, 175, 206, 194),
                    elevation: 5, // Tambahkan elevasi untuk efek bayangan
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Sudut melengkung
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40, // Ukuran avatar
                            backgroundColor:
                                Colors.grey[300], // Warna latar belakang
                            child: Icon(
                              Icons.person, // Ikon orang
                              size: 40, // Ukuran ikon
                              color: Colors.black, // Warna ikon
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              color: Color.fromARGB(255, 59, 142, 110),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.name}', // Nama petugas
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .white, // Latar belakang putih
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.phone),
                                            iconSize: 15,
                                            color: Color.fromARGB(
                                                255, 175, 206, 194),
                                            onPressed: () async {
                                              String cleanedNumber = controller
                                                  .cleanPhoneNumber(controller
                                                      .number!); // Bersihkan nomor
                                              final Uri launchUri = Uri(
                                                scheme: 'tel',
                                                path:
                                                    cleanedNumber, // Menggunakan nomor yang sudah dibersihkan
                                              );
                                              try {
                                                await launchUrl(
                                                    launchUri); // Menggunakan launchUrl
                                              } catch (e) {
                                                // Jika tidak bisa meluncurkan, Anda bisa menampilkan pesan kesalahan
                                                if (context.mounted) {
                                                  controller.showSnackBar(
                                                      context,
                                                      'Tidak dapat membuka aplikasi telepon.',
                                                      const Color.fromARGB(
                                                          255, 181, 61, 62),
                                                      2000);
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .white, // Latar belakang putih
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.report),
                                            iconSize: 15,
                                            color: const Color.fromARGB(
                                                255, 181, 61, 62),
                                            onPressed: () {
                                              // Navigasi ke halaman tambah pengaduan
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintAdd(
                                                    initialDescription:
                                                        'Ada masalah pengangkutan sampah di kecamatan ${controller.workArea} pada tanggal $formattedDate / ${widget.transportationTime}',
                                                  ), // Ganti dengan halaman pengaduan
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Area bertugas: Kec.${controller.workArea}', // Area bertugas
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

    return Scaffold(
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
                '$formattedDate / ${widget.transportationTime}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      body: controller.isLoading
          ? Center(
              child: CircularProgressIndicator()) // Tampilkan loading indicator
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(widget.coordinates.latitude - 0.010,
                    widget.coordinates.longitude),
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: widget.coordinates,
                      radius: 1000,
                      useRadiusInMeter: true,
                      color: const Color.fromARGB(149, 217, 153, 176),
                      borderColor: Colors.black,
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: () => showSlider(context),
            backgroundColor: const Color.fromARGB(
                255, 59, 142, 110), // Panggil fungsi showSlider
            child: const Icon(Icons.list),
          ),
        ),
      ),
    );
  }
}
