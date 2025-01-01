import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TpsInformation extends StatefulWidget {
  const TpsInformation({super.key});

  @override
  State<TpsInformation> createState() => _TpsInformationState();
}

class _TpsInformationState extends State<TpsInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        leading: Icon(Icons.location_on, color: Colors.white,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Informasi TPS',
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
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    margin: const EdgeInsets.only(top: 7.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 28),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 59, 142, 110)),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Kecamatan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              _buildTombolKecamatan('Batam Kota'),
                              _buildTombolKecamatan('Batu Aji'),
                              _buildTombolKecamatan('Batu Ampar'),
                              _buildTombolKecamatan('B. Padang'),
                              _buildTombolKecamatan('Bengkong'),
                              _buildTombolKecamatan('Bulang'),
                              _buildTombolKecamatan('Galang'),
                              _buildTombolKecamatan('Lubuk Baja'),
                              _buildTombolKecamatan('Nongsa'),
                              _buildTombolKecamatan('Sagulung'),
                              _buildTombolKecamatan('Sei Beduk'),
                              _buildTombolKecamatan('Sekupang'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun tombol kecamatan
  Widget _buildTombolKecamatan(String district) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/detail_informasi_tps',
          arguments: {
            'district': district,
          },
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        fixedSize: const Size.fromWidth(140),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        district,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGreen = Paint()..color = Color.fromARGB(255, 59, 142, 110);
    final paintWhite = Paint()..color = Colors.white;

    final pathWhite = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    final pathGreen = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(pathWhite, paintWhite);
    canvas.drawPath(pathGreen, paintGreen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
