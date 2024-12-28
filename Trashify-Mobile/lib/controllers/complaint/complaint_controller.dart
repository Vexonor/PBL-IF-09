import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/services/complaint_service.dart';

class ComplaintController {
  final ComplaintService service = ComplaintService();
  final ScrollController completedScrollController = ScrollController();
  final ScrollController inProgressScrollController = ScrollController();
  final ScrollController unresolvedScrollController = ScrollController();

  int? userId;
  bool isLoading = true;
  List<dynamic> completedComplaints = [];
  List<dynamic> inProgressComplaints = [];
  List<dynamic> unresolvedComplaints = [];

  // Mengambil ID pengguna saat ini dari model pengguna
  Future<void> getCurrentUserId(BuildContext context) async {
    final userModel = Provider.of<UserProvider>(context, listen: false);
    await userModel.loadUserData();
    userId = userModel.userId;
    if (context.mounted) {
      await fetchPengaduan(context, userId);
    }
  }

  // Mengambil data pengaduan berdasarkan ID pengguna
  Future<void> fetchPengaduan(BuildContext context, int? userId) async {
    isLoading = true;
    try {
      final response = await service.getComplaint();
      if (response.statusCode == 200) {
        final List<dynamic> allPengaduan = json.decode(response.body);
        allPengaduan.sort((a, b) {
          String? createdAtA = a['created_at'];
          String? createdAtB = b['created_at'];
          if (createdAtA == null && createdAtB == null) return 0;
          if (createdAtA == null) return 1;
          if (createdAtB == null) return -1;
          DateTime dateA = DateTime.parse(createdAtA);
          DateTime dateB = DateTime.parse(createdAtB);
          return dateB.compareTo(dateA);
        });

        unresolvedComplaints = allPengaduan
            .where((pengaduan) =>
                pengaduan['Status_Pengaduan'] == 'Belum Selesai' &&
                pengaduan['ID_User'] == userId)
            .toList();
        inProgressComplaints = allPengaduan
            .where((pengaduan) =>
                pengaduan['Status_Pengaduan'] == 'Sedang Diproses' &&
                pengaduan['ID_User'] == userId)
            .toList();
        completedComplaints = allPengaduan
            .where((pengaduan) =>
                pengaduan['Status_Pengaduan'] == 'Selesai' &&
                pengaduan['ID_User'] == userId)
            .toList();
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Gagal memuat Pengaduan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
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

  // Mengurutkan pengaduan berdasarkan tanggal dibuat
  void sortComplaintsByCreatedAt(String status, bool isAscending) {
    List<dynamic> complaintsToSort;

    if (status == 'Belum Selesai') {
      complaintsToSort = unresolvedComplaints;
    } else if (status == 'Sedang Diproses') {
      complaintsToSort = inProgressComplaints;
    } else {
      complaintsToSort = completedComplaints;
    }

    complaintsToSort.sort((a, b) {
      String? createdAtA = a['created_at'];
      String? createdAtB = b['created_at'];
      if (createdAtA == null && createdAtB == null) return 0;
      if (createdAtA == null) return isAscending ? 1 : -1;
      if (createdAtB == null) return isAscending ? -1 : 1;
      DateTime dateA = DateTime.parse(createdAtA);
      DateTime dateB = DateTime.parse(createdAtB);
      return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    if (status == 'Belum Selesai') {
      unresolvedComplaints = complaintsToSort;
    } else if (status == 'Sedang Diproses') {
      inProgressComplaints = complaintsToSort;
    } else {
      completedComplaints = complaintsToSort;
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
