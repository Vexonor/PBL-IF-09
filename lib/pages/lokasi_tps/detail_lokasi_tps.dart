import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLokasiTps extends StatefulWidget {
  final String kecamatan;
  const DetailLokasiTps({super.key, required this.kecamatan});

  @override
  State<DetailLokasiTps> createState() => _DetailLokasiTpsState();
}

class _DetailLokasiTpsState extends State<DetailLokasiTps> {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> tpsData = {
      'Batam Kota': [
        {
          'namaTps': 'TPS Kamp. Jabi',
          'status': 'Kosong',
          'jarakTps': '7 menit',
          'koordinat': const LatLng(1.0828, 104.0305)
        },
        {
          'namaTps': 'TPS 02',
          'status': 'Penuh',
          'jarakTps': '15 menit',
          'koordinat': const LatLng(1.1825, 104.0302)
        },
      ],
      'Sagulung': [
        {
          'namaTps': 'TPS Kaling Baru Sagulung',
          'status': 'Kosong',
          'jarakTps': '23 menit',
          'koordinat': const LatLng(1.0828, 104.0305)
        },
      ],
    };
    final List<Map<String, dynamic>> selectedTps =
        tpsData[widget.kecamatan] ?? [];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Center(
          widthFactor: 1.2,
          child: Text(
            'Lokasi TPS - ${widget.kecamatan}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // TODO: Halaman Notifikasi
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: selectedTps.length,
        itemBuilder: (context, index) {
          final tps = selectedTps[index];
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: tps['koordinat'],
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: tps['koordinat'],
                          child: const Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          ),
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
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text(tps['namaTps']!, style: GoogleFonts.poppins()),
                  subtitle: Text('${tps['status']} - ${tps['jarakTps']}',
                      style: GoogleFonts.poppins()),
                  leading: const Icon(Icons.location_on),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/beranda');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/lokasi_tps');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/bank_sampah');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/akun');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Lokasi TPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Bank Sampah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
