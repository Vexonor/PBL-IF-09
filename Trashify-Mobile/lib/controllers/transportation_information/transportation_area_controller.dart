import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:trashify/services/transportation_information_service.dart';

class TransportationAreaController {
  final TransportationInformationService service =
      TransportationInformationService();

  bool isLoading = true;
  String? name;
  String? number;
  String? workArea;

  // Mengambil informasi pekerja berdasarkan ID
  Future<void> fetchWorkerInformation(
      BuildContext context, Function updateState, String idPetugas) async {
    updateState(() {
      isLoading = true;
    });

    try {
      final response = await service.getWorkerInformation(idPetugas);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        workArea = data['Wilayah_Bertugas'];
        name = data['Nama'];
        number = data['No_Telp'];
        updateState(() {});
      } else if (response.statusCode == 403 || response.statusCode == 404) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      updateState(() {
        isLoading = false;
      });
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

  // Membersihkan nomor telepon dengan menghapus karakter yang tidak diperlukan
  String cleanPhoneNumber(String number) {
    return number.replaceAll(RegExp(r'[^0-9+]'), '');
  }
}
