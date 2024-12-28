import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trashify/services/complaint_service.dart';

class ComplaintDetailController {
  final ComplaintService service = ComplaintService();

  bool isLoading = true;
  bool isProcessing = false;
  Map<String, dynamic>? complaintDetails;
  String? complaintId;

  // Mengatur ID pengaduan
  void setcomplaintId(String id) {
    complaintId = id;
  }

  // Mengambil detail pengaduan dari layanan
  Future<void> fetchComplaintDetails(BuildContext context) async {
    isLoading = true;

    try {
      if (complaintId != null) {
        final response = await service.getDetailComplaint(complaintId!);
        if (response.statusCode == 200) {
          complaintDetails = json.decode(response.body);
        } else if (response.statusCode == 404) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        } else {
          if (context.mounted) {
            showSnackBar(
                context,
                'Gagal memuat Detail Pengaduan, silakan coba lagi!',
                const Color.fromARGB(255, 181, 61, 62),
                2000);
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    } finally {
      isLoading = false;
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
              '/pengaduan',
              (Route<dynamic> route) => route.isFirst,
            );
          }
          if (context.mounted) {
            showSnackBar(context, data['message'],
                Color.fromARGB(255, 59, 142, 110), 2000);
          }
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
      isProcessing = false;
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
                      Navigator.of(context).pop();
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
                      deleteComplaint(context);
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

  // Menampilkan snackbar dengan pesan
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
