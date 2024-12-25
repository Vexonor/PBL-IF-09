import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/controllers/tps_information/tps_information_detail_controller.dart';
import 'package:trashify/pages/notification.dart';
import 'package:url_launcher/url_launcher.dart';

class TpsInformationDetail extends StatefulWidget {
  const TpsInformationDetail({super.key});

  @override
  State<TpsInformationDetail> createState() => _TpsInformationDetailState();
}

class _TpsInformationDetailState extends State<TpsInformationDetail> {
  final TpsInformationDetailController controller =
      TpsInformationDetailController();
  bool isLoading = false; // Local loading state
  final MapController mapController = MapController(); // Create a MapController
  String? selectedTpsCode; // Track the selected TPS code

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      controller.setDistrict(args['district']);
      controller.fetchTpsInformationDetail(context, (loading) {
        setState(() {
          isLoading = loading; // Update local loading state
        });
        if (!loading) {
          // Cek apakah data ditemukan sebelum membuka bottom sheet
          if (controller.tpsInformationDetail != null &&
              controller.tpsInformationDetail!.isNotEmpty) {
            _showBottomSheet(); // Show bottom sheet after loading
          }
        }
      });
    });
  }

  void _showBottomSheet() {
    List<Map<String, dynamic>> sortedTpsList = [];
    if (controller.tpsInformationDetail != null) {
      sortedTpsList.addAll(
          controller.tpsInformationDetail!.cast<Map<String, dynamic>>());
    }

    controller.showBottomSheet(context, sortedTpsList, selectedTpsCode,
        (tpsCode) {
      setState(() {
        selectedTpsCode = tpsCode; // Set selected TPS code
      });
      // Move the map to the selected TPS location
      final selectedTps = controller.tpsInformationDetail!
          .firstWhere((tps) => tps['Kode_TPS'] == tpsCode);
      final String coordinatePoint = selectedTps['Titik_Koordinat'];
      List<String> coordinates = coordinatePoint.split(',');
      double latitude = double.parse(coordinates[0].trim());
      double longitude = double.parse(coordinates[1].trim());
      mapController.move(LatLng(latitude, longitude), 18);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Lokasi TPS - ${controller.district}',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationCenter()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.tpsInformationDetail != null &&
                  controller.tpsInformationDetail!.isNotEmpty
              ? Builder(builder: (context) {
                  List<LatLng> markers = [];
                  for (var tps in controller.tpsInformationDetail!) {
                    final String coordinatePoint = tps['Titik_Koordinat'];
                    double latitude = 0;
                    double longitude = 0;
                    if (coordinatePoint.isNotEmpty) {
                      List<String> coordinates = coordinatePoint.split(',');
                      if (coordinates.length == 2) {
                        latitude = double.parse(coordinates[0].trim());
                        longitude = double.parse(coordinates[1].trim());
                        markers.add(LatLng(latitude, longitude));
                      }
                    }
                  }

                  double centerLatitude = markers.isNotEmpty
                      ? markers.map((m) => m.latitude).reduce((a, b) => a + b) /
                          markers.length
                      : 0.0;
                  double centerLongitude = markers.isNotEmpty
                      ? markers
                              .map((m) => m.longitude)
                              .reduce((a, b) => a + b) /
                          markers.length
                      : 0.0;

                  return Column(
                    children: [
                      Expanded(
                        child: FlutterMap(
                          mapController:
                              mapController, // Pass the controller here
                          options: MapOptions(
                            initialCenter:
                                LatLng(centerLatitude, centerLongitude),
                            initialZoom: 13,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            MarkerLayer(
                              markers: markers.map((marker) {
                                final tps = controller.tpsInformationDetail!
                                    .firstWhere((t) {
                                  final String coordinatePoint =
                                      t['Titik_Koordinat'];
                                  List<String> coordinates =
                                      coordinatePoint.split(',');
                                  double lat =
                                      double.parse(coordinates[0].trim());
                                  double lon =
                                      double.parse(coordinates[1].trim());
                                  return LatLng(lat, lon) == marker;
                                });

                                return Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: marker,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTpsCode = tps[
                                            'Kode_TPS']; // Set selected TPS code
                                      });
                                      _showBottomSheet(); // Show bottom sheet
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      size: 40,
                                      color: Color.fromARGB(255, 181, 61, 62),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            RichAttributionWidget(
                              attributions: [
                                TextSourceAttribution(
                                  'OpenStreetMap contributors',
                                  onTap: () => launchUrl(Uri.parse(
                                      'https://openstreetmap.org/copyright')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
              : Center(child: Text('Data tidak ditemukan')),
      floatingActionButton: controller.tpsInformationDetail != null &&
              controller.tpsInformationDetail!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Align(
                alignment: Alignment.bottomLeft, // Pindahkan ke kiri bawah
                child: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheet(); // Panggil fungsi untuk membuka BottomSheet
                  }, // Ikon untuk tombol
                  backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                  child: const Icon(Icons.list), // Warna latar belakang tombol
                ),
              ),
            )
          : null,
    );
  }
}
