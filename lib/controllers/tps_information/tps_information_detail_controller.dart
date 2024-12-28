import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/tps_information_service.dart';

class TpsInformationDetailController {
  final TpsInformationService service = TpsInformationService();
  
  List<dynamic>? tpsInformationDetail;
  String? district;

  // Mengatur distrik yang akan digunakan
  void setDistrict(String district) {
    this.district = district;
  }

  // Mengambil detail informasi TPS berdasarkan distrik
  Future<void> fetchTpsInformationDetail(
      BuildContext context, Function(bool) setLoading) async {
    setLoading(true);

    try {
      if (district != null) {
        final response = await service.getTpsInformationDetail(district!);
        if (response.statusCode == 200) {
          if (context.mounted) {
            tpsInformationDetail = json.decode(response.body);
          }
        } else if (response.statusCode == 404) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        } else {
          if (context.mounted) {
            showSnackBar(context, 'Gagal memuat Lokasi TPS, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
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