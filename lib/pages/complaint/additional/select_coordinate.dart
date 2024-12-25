import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashify/pages/settings/general_setting.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SelectCoordinate extends StatefulWidget {
  final LatLng? initialCoordinate; // Optional parameter

  const SelectCoordinate({super.key, this.initialCoordinate});

  @override
  State<SelectCoordinate> createState() => _SelectCoordinateState();
}

class _SelectCoordinateState extends State<SelectCoordinate> {
  LatLng? _selectedCoordinate;
  LatLng? _currentLocation;
  final LatLng _startCoordinate = const LatLng(1.0828, 104.0305);
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStream; // Updated type
  bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToLocationChanges();
  }

  @override
  void dispose() {
    _positionStream?.cancel(); // Stop listening to location updates
    super.dispose();
  }

  void _listenToLocationChanges() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen(
      (Position position) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          // Move the map to the user's location
          _mapController.move(_currentLocation!, 18);
        });
      },
      onError: (error) {
        // Tampilkan SnackBar dengan tombol untuk membuka pengaturan
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Izin lokasi ditolak. Anda dapat mengaktifkannya di pengaturan atau atur ulang di pengaturan aplikasi.'),
              action: SnackBarAction(
                label: 'Buka Pengaturan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GeneralSetting()),
                  );
                },
              ),
            ),
          );
        }
        // Atur peta ke initialCoordinate jika terjadi kesalahan
        setState(() {
          _currentLocation = widget.initialCoordinate ?? _startCoordinate;
          _mapController.move(_currentLocation!, 18);
        });
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        // Jika izin ditolak, atur peta ke initialCoordinate
        setState(() {
          _currentLocation = widget.initialCoordinate ?? _startCoordinate;
          _mapController.move(_currentLocation!, 18);
          _hasLocationPermission = false; // Izin tidak diberikan
        });

        // Tampilkan SnackBar dengan tombol untuk membuka pengaturan
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Izin lokasi ditolak. Anda dapat mengaktifkannya di pengaturan.'),
              action: SnackBarAction(
                label: 'Buka Pengaturan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GeneralSetting()),
                  );
                },
              ),
            ),
          );
        }
        return; // Keluar dari fungsi jika izin ditolak
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        _hasLocationPermission = true; // Izin diberikan
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        );
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _mapController.move(
            _currentLocation ?? widget.initialCoordinate ?? _startCoordinate,
            18,
          );
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = widget.initialCoordinate ?? _startCoordinate;
        _mapController.move(_currentLocation!, 18);
        _hasLocationPermission = false; // Izin tidak diberikan
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat mengakses lokasi.'),
          ),
        );
      }
    }
  }

  void _markLocation(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _selectedCoordinate = latLng;
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Pilih Koordinat',
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
      body: Stack(
        children: [
          // The map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? _startCoordinate,
              initialZoom: 13,
              onTap: _markLocation,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  if (_currentLocation != null && _hasLocationPermission)
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: _currentLocation!,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 58, 103, 134)
                              .withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (_selectedCoordinate != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _selectedCoordinate!,
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Color.fromARGB(255, 181, 61, 62),
                      ),
                    ),
                  if (widget.initialCoordinate != null)
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: widget.initialCoordinate!,
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Color.fromARGB(255, 59, 142, 110),
                      ),
                    ),
                ],
              ),
            ],
          ),
          // The floating legend
          Positioned(
            top: 16.0,
            right: 16.0,
            child: _buildLegend(),
          ),
          // Positioned button at the bottom center
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: _selectedCoordinate != null
                    ? () {
                        Navigator.pop(context, _selectedCoordinate);
                      }
                    : null,
                icon: const Icon(Icons.check),
                label: Text(
                  'Konfirmasi Lokasi',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToMarker(LatLng latLng) {
    _mapController.move(latLng,
        18); // Move the map to the specified coordinates with a zoom level of 18
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Legenda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (_currentLocation != null) {
                _moveToMarker(_currentLocation!); // Move to current location
              }
            },
            child: Row(
              children: [
                Icon(Icons.my_location,
                    color: const Color.fromARGB(255, 58, 103, 134)),
                SizedBox(width: 8),
                Text('Lokasi Saya', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (_selectedCoordinate != null) {
                _moveToMarker(
                    _selectedCoordinate!); // Move to selected coordinate
              }
            },
            child: Row(
              children: [
                Icon(Icons.location_on,
                    color: const Color.fromARGB(255, 181, 61, 62)),
                SizedBox(width: 8),
                Text('Koordinat Terpilih',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (widget.initialCoordinate != null) {
                _moveToMarker(
                    widget.initialCoordinate!); // Move to initial coordinate
              }
            },
            child: Row(
              children: [
                Icon(Icons.location_on,
                    color: Color.fromARGB(255, 59, 142, 110)),
                SizedBox(width: 8),
                Text('Koordinat Sebelumnya',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 16), // Add some space before the copyright
          GestureDetector(
            onTap: () async {
              const url = 'https://openstreetmap.org/copyright';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              'OpenStreetMap contributors',
              style: TextStyle(
                color: const Color.fromARGB(255, 58, 103, 134),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
