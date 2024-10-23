import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LokasiPengangkutan extends StatefulWidget {
  final DateTime selectedDate;
  final String jamPengangkutan;
  const LokasiPengangkutan(
      {super.key, required this.selectedDate, required this.jamPengangkutan});

  @override
  State<LokasiPengangkutan> createState() => _LokasiPengangkutanState();
}

class _LokasiPengangkutanState extends State<LokasiPengangkutan> {
  final MapController _mapController = MapController();

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
        title: Center(
          widthFactor: 1.2,
          child: Text(
            '$formattedDate / ${widget.jamPengangkutan}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(1.0828, 104.0305),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: LatLng(1.0828, 104.0305),
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
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
