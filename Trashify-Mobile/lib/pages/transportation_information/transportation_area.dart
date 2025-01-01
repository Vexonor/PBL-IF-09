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
  final LatLng coordinates;
  final String idWorker;
  final String transportationTime;

  const TransportationArea({
    super.key,
    required this.selectedDate,
    required this.coordinates,
    required this.idWorker,
    required this.transportationTime,
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
      if (controller.name != null) {
        if (mounted) {
          showSlider(context);
        }
      }
    });
  }

  // Menampilkan modal bottom sheet dengan informasi petugas
  void showSlider(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 1 / 3.3,
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
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              color: Color.fromARGB(255, 59, 142, 110),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.name}',
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
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.phone),
                                            iconSize: 15,
                                            color: Color.fromARGB(
                                                255, 175, 206, 194),
                                            onPressed: () async {
                                              String cleanedNumber =
                                                  controller.cleanPhoneNumber(
                                                      controller.number!);
                                              final Uri launchUri = Uri(
                                                scheme: 'tel',
                                                path: cleanedNumber,
                                              );
                                              try {
                                                await launchUrl(launchUri);
                                              } catch (e) {
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
                                        SizedBox(width: 12),
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.report),
                                            iconSize: 15,
                                            color: const Color.fromARGB(
                                                255, 181, 61, 62),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintAdd(
                                                    initialDescription:
                                                        'Ada masalah pengangkutan sampah di kecamatan ${controller.workArea} pada tanggal $formattedDate / ${widget.transportationTime}',
                                                    initialCoordinates:
                                                        '${widget.coordinates.latitude}, ${widget.coordinates.longitude}',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Area bertugas: Kec.${controller.workArea}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
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
          ? Center(child: CircularProgressIndicator())
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
            backgroundColor: const Color.fromARGB(255, 59, 142, 110),
            child: const Icon(Icons.list),
          ),
        ),
      ),
    );
  }
}
