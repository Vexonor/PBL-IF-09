import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class BankSampah extends StatefulWidget {
  const BankSampah({super.key});

  @override
  State<BankSampah> createState() => _BankSampahState();
}

class _BankSampahState extends State<BankSampah> {
  final MapController _mapController = MapController();
  bool _modalTerbuka = false;
  bool _kondisiSampahTerpilih = false;

  void _toggleModal() {
    setState(() {
      _modalTerbuka = !_modalTerbuka;
    });
  }

  JenisSampah? _sampahTerpilih;
  double _latitudeTerkini = 1.0828;
  double _longitudeTerkini = 104.0305;

  final List<JenisSampah> jenisSampahList = [
    JenisSampah(
      nama: 'Plastik',
      icon: Icons.shopping_bag,
      bankSampah: DetailBankSampah(
        namaBank: 'Bank Sampah Kita',
        nomorTelpon: '+62 896-1297-0033',
        jamOperasional: '06.00 - 17.00',
        status: 'Buka',
        kordinatLatitude: 1.1022518592374857,
        kordinatLongitude: 103.98770545397619,
      ),
    ),
    JenisSampah(
      nama: 'Kertas',
      icon: Icons.description,
      bankSampah: DetailBankSampah(
        namaBank: 'Bank Sampah Kamu',
        nomorTelpon: '+62 896-1297-1598',
        jamOperasional: '08.00 - 20.00',
        status: 'Buka',
        kordinatLatitude: 1.032927583184759,
        kordinatLongitude: 103.97502762583923,
      ),
    ),
    JenisSampah(
      nama: 'Besi',
      icon: Icons.construction,
      bankSampah: DetailBankSampah(
        namaBank: 'Bank Sampah Aku',
        nomorTelpon: '+62 896-4724-9603',
        jamOperasional: '10.00 - 17.00',
        status: 'Buka',
        kordinatLatitude: 1.0406992992140933,
        kordinatLongitude: 103.95928685373055,
      ),
    ),
    JenisSampah(
      nama: 'Botol Kaca',
      icon: Icons.liquor,
      bankSampah: DetailBankSampah(
        namaBank: 'Bank Sampah Kalian',
        nomorTelpon: '+62 896-2156-8535',
        jamOperasional: '05.00 - 12.00',
        status: 'Buka',
        kordinatLatitude: 1.1803204867097832,
        kordinatLongitude: 104.02262251648999,
      ),
    ),
    JenisSampah(
      nama: 'Elektronik',
      icon: Icons.developer_board_off,
      bankSampah: DetailBankSampah(
        namaBank: 'Bank Sampah Kami',
        nomorTelpon: '+62 896-1532-9328',
        jamOperasional: '10.00 - 03.00',
        status: 'Buka',
        kordinatLatitude: 1.0422834247309472,
        kordinatLongitude: 103.96806034384643,
      ),
    ),
  ];

  void _munculkanSlider(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const Divider(thickness: 5, indent: 150, endIndent: 150),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: jenisSampahList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final jenisSampah = jenisSampahList[index];
                      return Column(
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  _sampahTerpilih = jenisSampah;
                                  _latitudeTerkini =
                                      jenisSampah.bankSampah.kordinatLatitude;
                                  _longitudeTerkini =
                                      jenisSampah.bankSampah.kordinatLongitude;
                                  _kondisiSampahTerpilih = true;
                                });
                                _mapController.move(
                                  LatLng(_latitudeTerkini, _longitudeTerkini),
                                  15.0,
                                );
                              },
                              child: ListTile(
                                leading: Icon(jenisSampah.icon as IconData?,
                                    color: Colors.grey[700]),
                                title: Text(
                                  jenisSampah.nama,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        title: Center(
          child: Text(
            'Bank Sampah',
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.account_balance,
            color: Colors.white,
          ),
          onPressed: () {
            // TODO: Halaman Notifikasi
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jenis Sampah',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            _munculkanSlider(context);
                          },
                          child: ListTile(
                            leading:
                                Icon(Icons.recycling, color: Colors.grey[700]),
                            title: Text(
                              _sampahTerpilih?.nama ?? 'Pilih Jenis Sampah',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!_kondisiSampahTerpilih)
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: _buildMaps(1.0828, 104.0305),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                if (_sampahTerpilih != null) ...[
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 59, 142, 110),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pemilik Bank Sampah',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          _buildDetailPemilik(
                              'Nama Bank Sampah: ${_sampahTerpilih!.bankSampah.namaBank}'),
                          _buildDetailPemilik(
                              'No. Telpon: ${_sampahTerpilih!.bankSampah.nomorTelpon}'),
                          _buildDetailPemilik(
                              'Jam Operasional: ${_sampahTerpilih!.bankSampah.jamOperasional}'),
                          _buildDetailPemilik(
                              'Status Bank Sampah: ${_sampahTerpilih!.bankSampah.status}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'Lokasi Bank Sampah',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: _buildMaps(
                        _sampahTerpilih!.bankSampah.kordinatLatitude,
                        _sampahTerpilih!.bankSampah.kordinatLongitude),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _modalTerbuka
          ? DraggableScrollableSheet(
              initialChildSize: 1.0,
              minChildSize: 1.0,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  color: Colors.white,
                  child: _buildMaps(
                      _sampahTerpilih!.bankSampah.kordinatLatitude,
                      _sampahTerpilih!.bankSampah.kordinatLongitude),
                );
              },
            )
          : const SizedBox(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 2,
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

  Widget _buildDetailPemilik(String title) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaps(double lat, double lng) {
    return FlutterMap(
      mapController: _modalTerbuka ? null : _mapController,
      options: MapOptions(
        initialCenter: LatLng(_latitudeTerkini, _longitudeTerkini),
        initialZoom: _kondisiSampahTerpilih ? 15 : 10,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(_latitudeTerkini, _longitudeTerkini),
              child: Icon(
                Icons.location_on,
                size: 40,
                color: _kondisiSampahTerpilih ? Colors.red : Colors.transparent,
              ),
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
        Positioned(
          right: 10,
          top: 10,
          child: _kondisiSampahTerpilih
              ? ElevatedButton(
                  onPressed: _toggleModal,
                  child: Icon(
                      _modalTerbuka ? Icons.fullscreen_exit : Icons.fullscreen),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class JenisSampah {
  final String nama;
  final IconData icon;
  final DetailBankSampah bankSampah;

  JenisSampah(
      {required this.nama, required this.icon, required this.bankSampah});
}

class DetailBankSampah {
  final String namaBank;
  final String nomorTelpon;
  final String jamOperasional;
  final String status;
  final double kordinatLongitude;
  final double kordinatLatitude;

  DetailBankSampah({
    required this.namaBank,
    required this.nomorTelpon,
    required this.jamOperasional,
    required this.status,
    required this.kordinatLatitude,
    required this.kordinatLongitude,
  });
}
