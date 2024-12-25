import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/controllers/waste_bank/waste_bank_controller.dart';
import 'package:trashify/pages/notification.dart';

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
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.account_balance, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationCenter()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/notifikasi');
            },
          ),
        ],
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
                width: double.infinity, // Mengatur lebar tombol selebar layar
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: controller.selectedWasteType == null
                        ? Colors.black
                        : Color.fromARGB(255, 59, 142, 110),
                  ),
                  onPressed: () {
                    controller.showSlider(context, (selectedWasteType) {
                      setState(() {
                        controller.selectedWasteType = selectedWasteType;
                      });
                      controller
                          .fetchWasteBank(context, selectedWasteType)
                          .then((_) {
                        setState(() {
                          // Pembaruan state jika diperlukan
                        });
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Rata kiri
                    children: [
                      // Menentukan ikon berdasarkan jenis sampah yang dipilih
                      Icon(
                        _getIconForWasteType(controller.selectedWasteType),
                        color: Color.fromARGB(255, 59, 142, 110),
                      ),
                      const SizedBox(width: 10), // Jarak antara ikon dan teks
                      Text(
                        controller.selectedWasteType ?? 'Pilih Jenis Sampah',
                        style: TextStyle(fontSize: 16),
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
                      color: Colors.white, // Latar belakang putih
                      borderRadius:
                          BorderRadius.circular(10.0), // Sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Mengatur posisi bayangan
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.all(16.0), // Padding untuk memberikan jarak
                    child: Text('Harap memilih salah satu jenis sampah',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 181, 61, 62))),
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
                    padding: const EdgeInsets.only(
                        bottom: 20.0), // Atur jarak bawah sesuai kebutuhan
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
        // Use SizedBox instead of Expanded
        width: double.infinity,
        height: 300, // Set a fixed height for the map
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

  void _showWasteBankInformation(dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 59, 142, 110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            item['wasteBankName'],
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: 400, // Atur lebar maksimum dialog
              maxHeight: 500, // Atur tinggi maksimum dialog
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0), // Add left padding
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Jenis Sampah',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['wasteType']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Harga Sampah',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['wastePrice']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Nama Pemilik',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['wasteBankOwner']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'No. Telepon',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['phoneNumber']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Wilayah',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['wasteBankLocation']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Jam Buka',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['openTime']),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            'Jam Tutup',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
                          ),
                          subtitle: Text(item['closedTime']),
                        ),
                      ),
                      // Menambahkan bagian Status Operational
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          title: Text(
                            'Status Operational',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Bold title
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
              alignment: Alignment.centerRight, // Align to the right
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
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
