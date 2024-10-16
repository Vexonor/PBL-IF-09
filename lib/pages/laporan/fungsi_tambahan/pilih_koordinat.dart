import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class Pilihkoordinat extends StatefulWidget {
  const Pilihkoordinat({super.key});

  @override
  State<Pilihkoordinat> createState() => _PilihkoordinatState();
}

class _PilihkoordinatState extends State<Pilihkoordinat> {
  LatLng? _lokasiTerpilih;
  final LatLng _posisiAwal = const LatLng(1.0828, 104.0305);

  void _handleTap(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _lokasiTerpilih = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 142, 110),
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
          widthFactor: 2.15,
          child: Text(
            'Pilih Koordinat',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _posisiAwal,
                initialZoom: 13,
                onTap: _handleTap,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: _lokasiTerpilih != null
                      ? [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _lokasiTerpilih!,
                            child: const Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ]
                      : [],
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
          if (_lokasiTerpilih != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Koordinat terpilih:',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Latitude: ${_lokasiTerpilih!.latitude},',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Longitude: ${_lokasiTerpilih!.longitude}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _lokasiTerpilih != null
                  ? () {
                      Navigator.pop(context, _lokasiTerpilih);
                    }
                  : null,
              icon: const Icon(Icons.check),
              label: const Text('Konfirmasi Lokasi'),
            ),
          ),
        ],
      ),
    );
  }
}
