import 'dart:convert'; // Untuk encoding dan decoding JSON
import 'package:flutter/material.dart'; // Paket material Flutter untuk komponen UI
import 'package:trashify/services/complaint_service.dart'; // Mengimpor layanan pengaduan

// Kelas controller untuk mengelola detail pengaduan
class ComplaintDetailController {
  final ComplaintService service =
      ComplaintService(); // Instance dari layanan pengaduan
  Map<String, dynamic>? complaintDetails; // Menyimpan detail pengaduan
  String? complaintId; // Menyimpan ID pengaduan
  bool isLoading = true; // Status loading
  bool isProcessing = false;

  // Mengatur ID pengaduan
  void setcomplaintId(String id) {
    complaintId = id;
  }

  // Mengambil detail pengaduan dari layanan
  Future<void> fetchComplaintDetails(BuildContext context) async {
    isLoading = true; // Set loading menjadi true

    try {
      if (complaintId != null) {
        final response = await service.getDetailComplaint(complaintId!);
        if (response.statusCode == 200) {
          complaintDetails = json.decode(response.body); // Decode respons JSON
        } else if (response.statusCode == 404) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          } // Menangani error
        } else {
          if (context.mounted) {
            showSnackBar(
                context,
                'Gagal memuat Detail Pengaduan, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62),
                2000);
          } // Menangani error
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani pengecualian
    } finally {
      isLoading = false; // Set loading menjadi false
    }
  }

  // Menghapus pengaduan
  Future<void> deleteComplaint(BuildContext context) async {
    isProcessing = true;

    try {
      if (complaintId != null) {
        final response = await service.destroyComplaint(complaintId!);
        if (response.statusCode == 201) {
          final data = json.decode(response.body);
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/pengaduan', // Ganti dengan nama route yang sesuai
              (Route<dynamic> route) =>
                  route.isFirst, // Hanya menyisakan halaman pertama di stack
            );
          }
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 2000);
          }
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
          } // Menangani error
        }
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        } // Menangani kasus ID null
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani pengecualian
    } finally {
      isProcessing = false; // Set loading menjadi false
    }
  }

  // Menampilkan dialog konfirmasi untuk penghapusan
  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Konfirmasi Penghapusan',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 181, 61, 62)),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus pengaduan ini?',
            style: TextStyle(),
          ),
          actions: [
            TextButton(
              onPressed: isProcessing
                  ? null
                  : () {
                      Navigator.of(context)
                          .pop(); // Tutup dialog saat dibatalkan
                    },
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: isProcessing
                  ? null
                  : () {
                      deleteComplaint(context); // Panggil fungsi hapus
                    },
              child: Text(
                'Hapus',
                style: TextStyle(
                    color: const Color.fromARGB(255, 181, 61, 62),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
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
}
