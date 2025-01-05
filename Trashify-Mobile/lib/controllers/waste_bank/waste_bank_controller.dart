import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:trashify/services/waste_bank_service.dart';

class WasteBankController {
  final WasteBankService service = WasteBankService();
  final List<String> wasteTypeList = [
    'Plastik',
    'Kaca',
    'Kertas',
    'Logam',
    'Organik',
    'Elektronik',
  ];

  bool isGpsLoading = false;
  bool isLoading = true;
  List<dynamic>? wasteBank;
  List<LatLng> polylineCoordinates = [];
  String? selectedWasteType;
  LatLng? userLocation;

  // Mengambil data Bank Sampah berdasarkan jenis sampah
  Future<void> fetchWasteBank(BuildContext context, String wasteType) async {
    setLoading(true);
    try {
      final response = await service.getWasteBank(wasteType);
      if (response.statusCode == 200) {
        if (context.mounted) {
          final List<dynamic> data = json.decode(response.body);
          wasteBank = data.map((item) {
            return {
              'coordinateLatitude': item['Titik_Koordinat'].split(',')[0],
              'coordinateLongitude': item['Titik_Koordinat'].split(',')[1],
              'openTime': item['Jam_Buka'],
              'closedTime': item['Jam_Tutup'],
              'operationalStatus': item['Status_Operasional'],
              'phoneNumber': item['No_Telp'],
              'wasteBankLocation': item['Wilayah_BankSampah'],
              'wasteBankName': item['Nama_Bank_Sampah'],
              'wasteBankOwner': item['Nama_Pemilik'],
              'wastePrice': item['Harga_Sampah'],
              'wasteType': item['Jenis_Sampah'],
            };
          }).toList();
        }
      } else if (response.statusCode == 404) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Gagal memuat Bank Sampah, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false);
    }
  }

  // Mengatur status loading
  void setLoading(bool loading) {
    isLoading = loading;
  }

  // Menampilkan slider untuk memilih jenis sampah
  void showSlider(BuildContext context, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(thickness: 5, indent: 150, endIndent: 150),
              Expanded(
                child: ListView.builder(
                  itemCount: wasteTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final wasteType = wasteTypeList[index];
                    IconData icon;

                    switch (wasteType) {
                      case 'Plastik':
                        icon = Icons.recycling;
                        break;
                      case 'Kaca':
                        icon = Icons.local_drink;
                        break;
                      case 'Kertas':
                        icon = Icons.description;
                        break;
                      case 'Logam':
                        icon = Icons.build;
                        break;
                      case 'Organik':
                        icon = Icons.fastfood;
                        break;
                      case 'Elektronik':
                        icon = Icons.electrical_services;
                        break;
                      default:
                        icon = Icons.help;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onSelect(wasteType);
                        },
                        child: Row(
                          children: [
                            Icon(icon,
                                color: Color.fromARGB(255, 59, 142, 110)),
                            const SizedBox(width: 10),
                            Text(wasteType, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Mendapatkan lokasi pengguna
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    userLocation = LatLng(position.latitude, position.longitude);
    return userLocation!;
  }

  // Fungsi untuk mendapatkan rute dari OSRM
  Future<List<LatLng>> getRouteFromOSRM(LatLng start, LatLng end) async {
    final String url =
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> coordinates =
          data['routes'][0]['geometry']['coordinates'];
      return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
    } else {
      throw Exception('Failed to load route');
    }
  }

  // Menampilkan snackbar dengan pesan tertentu
  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 20.0 + keyboardHeight,
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
