import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:trashify/services/transportation_information_service.dart';

class TransportationAreaController {
  final TransportationInformationService service =
      TransportationInformationService();
  bool isLoading = true;
  String? workArea;
  String? name;
  String? number;

  Future<void> fetchWorkerInformation(
      BuildContext context, Function updateState, String idPetugas) async {
    updateState(() {
      isLoading = true;
    });

    try {
      final response = await service.getWorkerInformation(idPetugas);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Misalkan Anda ingin menyimpan data ini ke dalam variabel
        workArea = data['Wilayah_Bertugas'];
        name = data['Nama'];
        number = data['No_Telp'];
        // Lakukan sesuatu dengan data ini, misalnya menyimpannya ke dalam state
        updateState(() {});
      } else if (response.statusCode == 403) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        } // Menangani error
      } else if (response.statusCode == 404) {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        } // Menangani error
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

  void showSnackBar(
      BuildContext context, String message, Color color, int time) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        // Mendapatkan tinggi keyboard
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Positioned(
          bottom: 20.0 +
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

  String cleanPhoneNumber(String number) {
    return number.replaceAll(
        RegExp(r'[^0-9+]'), ''); // Menghapus semua karakter kecuali angka dan +
  }
}
