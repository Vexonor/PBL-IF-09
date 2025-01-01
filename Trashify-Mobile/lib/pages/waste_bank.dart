import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/controllers/waste_bank/waste_bank_controller.dart';

class WasteBank extends StatefulWidget {
  const WasteBank({super.key});

  @override
  State<WasteBank> createState() => _WasteBankState();
}

class _WasteBankState extends State<WasteBank> {
  final WasteBankController controller = WasteBankController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        leading: Icon(Icons.account_balance, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Bank Sampah',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Jenis Sampah',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: controller.selectedWasteType == null
                        ? Colors.black
                        : const Color.fromARGB(255, 59, 142, 110),
                  ),
                  onPressed: () {
                    controller.showSlider(context, (selectedWasteType) {
                      setState(() {
                        controller.selectedWasteType = selectedWasteType;
                      });
                      controller
                          .fetchWasteBank(context, selectedWasteType)
                          .then((_) {
                        setState(() {});
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        _getIconForWasteType(controller.selectedWasteType),
                        color: const Color.fromARGB(255, 59, 142, 110),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        controller.selectedWasteType ?? 'Pilih Jenis Sampah',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (controller.selectedWasteType == null)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Harap memilih salah satu jenis sampah',
                      style: TextStyle(color: Color.fromARGB(255, 181, 61, 62)),
                    ),
                  ),
                )
              else if (controller.isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: _buildMaps(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaps() {
    return Builder(builder: (context) {
      List<LatLng> markers = [];

      if (controller.wasteBank != null) {
        for (var item in controller.wasteBank!) {
          final String coordinatePoint =
              item['coordinateLatitude'] + ',' + item['coordinateLongitude'];
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
      }

      double centerLatitude = markers.isNotEmpty
          ? markers.map((m) => m.latitude).reduce((a, b) => a + b) /
              markers.length
          : 0.0;
      double centerLongitude = markers.isNotEmpty
          ? markers.map((m) => m.longitude).reduce((a, b) => a + b) /
              markers.length
          : 0.0;

      return SizedBox(
        width: double.infinity,
        height: 300,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(centerLatitude, centerLongitude),
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: markers.map((marker) {
                final item = controller.wasteBank!.firstWhere((b) {
                  return LatLng(
                        double.parse(b['coordinateLatitude']),
                        double.parse(b['coordinateLongitude']),
                      ) ==
                      marker;
                });

                return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: marker,
                  child: GestureDetector(
                    onTap: () {
                      _showWasteBankInformation(item);
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
          ],
        ),
      );
    });
  }

  // Menampilkan informasi bank sampah dalam dialog
  void _showWasteBankInformation(dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 59, 142, 110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            item['wasteBankName'],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          content: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 500,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Jenis Sampah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['wasteType']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Harga Sampah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['wastePrice']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Nama Pemilik',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['wasteBankOwner']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'No. Telepon',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['phoneNumber']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Wilayah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['wasteBankLocation']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Jam Buka',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['openTime']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Jam Tutup',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['closedTime']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          title: const Text(
                            'Status Operational',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['operationalStatus']),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ),
          ],
        );
      },
    );
  }

  // Mengambil ikon berdasarkan jenis sampah
  IconData _getIconForWasteType(String? wasteType) {
    switch (wasteType) {
      case 'Plastik':
        return Icons.recycling; // Ikon untuk plastik
      case 'Kaca':
        return Icons.local_drink; // Ikon untuk kaca
      case 'Kertas':
        return Icons.description; // Ikon untuk kertas
      case 'Logam':
        return Icons.build; // Ikon untuk logam
      case 'Organik':
        return Icons.fastfood; // Ikon untuk organik
      case 'Elektronik':
        return Icons.electrical_services; // Ikon untuk elektronik
      default:
        return Icons.help; // Ikon default jika tidak ada jenis yang dipilih
    }
  }
}
