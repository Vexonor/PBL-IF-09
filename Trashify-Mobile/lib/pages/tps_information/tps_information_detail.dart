import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/controllers/tps_information/tps_information_detail_controller.dart';
import 'package:trashify/pages/complaint/complaint_add.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TpsInformationDetail extends StatefulWidget {
  const TpsInformationDetail({super.key});

  @override
  State<TpsInformationDetail> createState() => _TpsInformationDetailState();
}

class _TpsInformationDetailState extends State<TpsInformationDetail> {
  final TpsInformationDetailController controller =
      TpsInformationDetailController();
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      controller.setDistrict(args['district']);
      controller.fetchTpsInformationDetail(context, (loading) {
        setState(() {
          controller.isLoading = loading;
        });
        if (!loading) {
          if (controller.tpsInformationDetail != null &&
              controller.tpsInformationDetail!.isNotEmpty) {
            _showBottomSheet();
          }
        }
      });
    });
  }

  // Fungsi untuk menampilkan rute ke TPS
  void _showRouteToTps(String tpsCoordinates) async {
    try {
      List<String> coordinates = tpsCoordinates.split(',');
      double tpsLatitude = double.parse(coordinates[0].trim());
      double tpsLongitude = double.parse(coordinates[1].trim());

      setState(() {
        controller.isGpsLoading = true;
      });

      LatLng userLocation = await controller.getCurrentLocation();

      setState(() {
        controller.isGpsLoading = false;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });

      List<LatLng> route = await controller.getRouteFromOSRM(
          userLocation, LatLng(tpsLatitude, tpsLongitude));

      double centerLatitude = (userLocation.latitude + tpsLatitude) / 2;
      double centerLongitude = (userLocation.longitude + tpsLongitude) / 2;

      mapController.move(LatLng(centerLatitude, centerLongitude), 13);

      setState(() {
        controller.polylineCoordinates = route;
      });
    } catch (e) {
      if (mounted) {
        controller.showSnackBar(
            context, 'Terjadi Kesalahan, Silakan coba lagi!', Colors.red, 2000);
      }
    }
  }

  // Fungsi untuk menampilkan di Google Maps
  void _showRouteInGoogleMaps(String tpsCoordinates) async {
    try {
      List<String> coordinates = tpsCoordinates.split(',');
      double tpsLatitude = double.parse(coordinates[0].trim());
      double tpsLongitude = double.parse(coordinates[1].trim());

      setState(() {
        controller.isGpsLoading = true;
      });

      LatLng userLocation = await controller.getCurrentLocation();

      setState(() {
        controller.isGpsLoading = false;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });

      final String url =
          'https://www.google.com/maps/dir/?api=1&origin=${userLocation.latitude},${userLocation.longitude}&destination=$tpsLatitude,$tpsLongitude&travelmode=driving';

      launchUrlString(url);
    } catch (e) {
      if (mounted) {
        controller.showSnackBar(
            context, 'Terjadi Kesalahan, Silakan coba lagi!', Colors.red, 2000);
      }
    }
  }

  void _showBottomSheet({Map<String, dynamic>? selectedTps}) {
    // Menampilkan bottom sheet untuk memilih TPS
    List<Map<String, dynamic>> sortedTpsList = [];

    if (selectedTps != null) {
      sortedTpsList.add(selectedTps);
    } else if (controller.selectedTpsCode != null) {
      final selectedTpsFromCode = controller.tpsInformationDetail!.firstWhere(
        (tps) => tps['Kode_TPS'] == controller.selectedTpsCode,
        orElse: () => null,
      );
      if (selectedTpsFromCode != null) {
        sortedTpsList.add(selectedTpsFromCode);
      }
    }

    sortedTpsList.addAll(controller.tpsInformationDetail!
        .where((tps) => tps['Kode_TPS'] != controller.selectedTpsCode)
        .cast<Map<String, dynamic>>());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              itemCount: sortedTpsList.length,
              itemBuilder: (context, index) {
                final tps = sortedTpsList[index];
                final String coordinatePoint = tps['Titik_Koordinat'];
                List<String> coordinates = coordinatePoint.split(',');
                double latitude = double.parse(coordinates[0].trim());
                double longitude = double.parse(coordinates[1].trim());

                bool isSelected = controller.selectedTpsCode == tps['Kode_TPS'];

                return GestureDetector(
                  onTap: () {
                    mapController.move(LatLng(latitude, longitude), 18);
                    setState(() {
                      controller.selectedTpsCode = tps['Kode_TPS'];
                    });
                    Navigator.pop(context);
                  },
                  child: Card(
                    color: isSelected
                        ? Color.fromARGB(255, 59, 142, 110)
                        : Colors.white,
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(8.0),
                        child: const Icon(Icons.location_on, color: Colors.red),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kode TPS: ${tps['Kode_TPS']}',
                            style: isSelected
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          Text(
                            'Titik Koordinat: ${tps['Titik_Koordinat']}',
                            style: isSelected
                                ? TextStyle(color: Colors.white, fontSize: 12)
                                : TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Status TPS: ${tps['Status_TPS']}',
                            style: isSelected
                                ? TextStyle(color: Colors.white, fontSize: 12)
                                : TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.rotate(
                            angle: 45 * 3.141592653589793238 / 180,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 58, 103, 134),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Transform.rotate(
                                angle: -45 * 3.141592653589793238 / 180,
                                child: IconButton(
                                  icon: const Icon(Icons.location_searching,
                                      color: Colors.white),
                                  iconSize: 16,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return controller.isGpsLoading
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              )
                                            : AlertDialog(
                                                title: Text('Pilih Aksi'),
                                                content: Text(
                                                    'Apa yang ingin Anda lakukan dengan koordinat ini?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        controller
                                                                .selectedTpsCode =
                                                            tps['Kode_TPS'];
                                                      });
                                                      _showRouteToTps(tps[
                                                          'Titik_Koordinat']);
                                                    },
                                                    child:
                                                        Text('Tampilkan Rute'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      _showRouteInGoogleMaps(tps[
                                                          'Titik_Koordinat']);
                                                    },
                                                    child: Text(
                                                        'Buka di Google Maps'),
                                                  ),
                                                ],
                                              );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Transform.rotate(
                            angle: 45 * 3.141592653589793238 / 180,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 181, 61, 62),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Transform.rotate(
                                angle: -45 * 3.141592653589793238 / 180,
                                child: IconButton(
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  iconSize: 16,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ComplaintAdd(
                                          initialCategory: 'Kondisi TPS',
                                          initialDescription:
                                              'Ada masalah kondisi TPS di kecamatan ${tps['Wilayah_TPS']} pada ${tps['Kode_TPS']}',
                                          initialCoordinates:
                                              tps['Titik_Koordinat'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      ),
      body: controller.isLoading
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
                          mapController: mapController,
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
                              markers: [
                                ...markers.map((marker) {
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
                                          controller.selectedTpsCode =
                                              tps['Kode_TPS'];
                                        });
                                        _showBottomSheet(selectedTps: tps);
                                      },
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 40,
                                        color: Color.fromARGB(255, 181, 61, 62),
                                      ),
                                    ),
                                  );
                                }),
                                if (controller.userLocation != null)
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: controller.userLocation!,
                                    child: const Icon(
                                      Icons.my_location,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                                  ),
                              ],
                            ),
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: controller.polylineCoordinates,
                                  strokeWidth: 4,
                                  color: Colors.blue,
                                ),
                              ],
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
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheet();
                  },
                  backgroundColor: const Color.fromARGB(255, 59, 142, 110),
                  child: const Icon(Icons.list),
                ),
              ),
            )
          : null,
    );
  }
}
