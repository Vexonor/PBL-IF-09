import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:trashify/services/education_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeController {
  final EducationService service = EducationService();
  List<dynamic>? educationContent;
  bool isLoading = false;

  Future<void> fetchEducationContent(
      BuildContext context, Function(bool) setLoading) async {
    setLoading(true); // Start loading

    try {
      final response = await service.getEducationContent();
      if (response.statusCode == 200) {
        if (context.mounted) {
          List<dynamic> allContent = json.decode(response.body);

          // Filter konten berdasarkan Jenis_Edukasi dan Status_Edukasi
          List<dynamic> videoContent = allContent
              .where((item) =>
                  item['Jenis_Edukasi'] == 'Video' &&
                  item['Status_Edukasi'] == 'Telah Diunggah')
              .toList();
          List<dynamic> artikelContent = allContent
              .where((item) =>
                  item['Jenis_Edukasi'] == 'Artikel' &&
                  item['Status_Edukasi'] == 'Telah Diunggah')
              .toList();

          // Sort and take the latest 10 for both types
          videoContent.sort((a, b) => DateTime.parse(b['created_at'])
              .compareTo(DateTime.parse(a['created_at'])));
          artikelContent.sort((a, b) => DateTime.parse(b['created_at'])
              .compareTo(DateTime.parse(a['created_at'])));

          educationContent = [
            ...videoContent.take(5),
            ...artikelContent.take(5)
          ];
        }
      } else {
        if (context.mounted) {
          showSnackBar(
              context,
              'Gagal memuat Konten Edukasi, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62),
              2000);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      setLoading(false); // Stop loading
    }
  }

  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        // Mendapatkan tinggi keyboard
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 100.0 +
              keyboardHeight, // Jarak dari bawah ditambah tinggi keyboard
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

  Widget buildResponsiveCard(BuildContext context, String rute, String image,
      String fitur, String description) {
    // Mengambil tinggi layar
    double screenHeight = MediaQuery.of(context).size.height;

    // Menetapkan tinggi card sebagai persentase dari tinggi layar
    double cardHeight = screenHeight * 0.23; // 20% dari tinggi layar

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, rute);
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Card(
          elevation: 5,
          color: Colors.white,
          child: Container(
            height: cardHeight, // Menggunakan tinggi responsif
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  fitur,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna lingkaran
                    shape: BoxShape.circle, // Bentuk lingkaran
                    border: Border.all(color: Colors.grey), // Border abu-abu
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -30, // Menonjol keluar dari bagian atas kartu
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset('assets/images/$image.png',
                width: 90, height: 90, fit: BoxFit.contain),
          ),
        ),
      ]),
    );
  }
}
