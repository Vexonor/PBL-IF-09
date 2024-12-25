import 'dart:convert'; // Untuk mengonversi data JSON
import 'package:flutter/material.dart'; // Untuk menggunakan widget dan material design di Flutter
import 'package:provider/provider.dart'; // Untuk mengelola state menggunakan Provider
import 'package:trashify/providers/user_provider.dart'; // Model pengguna untuk mengelola data pengguna
import 'package:trashify/services/complaint_service.dart'; // Layanan untuk mengelola pengaduan

// Kelas ComplaintController bertanggung jawab untuk mengelola pengaduan
class ComplaintController {
  final ComplaintService service =
      ComplaintService(); // Inisialisasi layanan pengaduan
  final ScrollController unresolvedScrollController = ScrollController();
  final ScrollController inProgressScrollController = ScrollController();
  final ScrollController completedScrollController = ScrollController();
  List<dynamic> unresolvedComplaints =
      []; // Menyimpan pengaduan yang belum selesai
  List<dynamic> inProgressComplaints =
      []; // Menyimpan pengaduan yang sedang diproses
  List<dynamic> completedComplaints =
      []; // Menyimpan pengaduan yang sudah selesai
  int? userId; // Menyimpan ID pengguna saat ini
  bool isLoading = true; // Menandakan apakah data sedang dimuat

  // Mengambil ID pengguna saat ini dari model pengguna
  Future<void> getCurrentUserId(BuildContext context) async {
    final userModel = Provider.of<UserProvider>(context, listen: false);
    await userModel.loadUserData(); // Memuat data pengguna
    userId = userModel.userId; // Menyimpan ID pengguna
    if (context.mounted) {
      await fetchPengaduan(
          context, userId); // Mengambil data pengaduan untuk pengguna
    }
  }

  // Mengambil data pengaduan berdasarkan ID pengguna
  Future<void> fetchPengaduan(BuildContext context, int? userId) async {
    isLoading = true; // Set loading menjadi true

    try {
      final response = await service.getComplaint(); // Mengambil data pengaduan

      // Memeriksa apakah respons berhasil
      if (response.statusCode == 200) {
        final List<dynamic> allPengaduan =
            json.decode(response.body); // Mengurai data JSON

        // Mengurutkan pengaduan berdasarkan created_at (terbaru terlebih dahulu)
        allPengaduan.sort((a, b) {
          String? createdAtA = a['created_at'];
          String? createdAtB = b['created_at'];

          // Jika salah satu tanggal adalah null, anggap lebih rendah
          if (createdAtA == null && createdAtB == null) return 0;
          if (createdAtA == null) return 1; // null dianggap lebih rendah
          if (createdAtB == null) return -1; // null dianggap lebih rendah

          DateTime dateA = DateTime.parse(createdAtA);
          DateTime dateB = DateTime.parse(createdAtB);
          return dateB.compareTo(dateA); // Urutkan terbaru terlebih dahulu
        });

        // Memfilter pengaduan berdasarkan status dan ID pengguna
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
        } // Menangani kesalahan jika respons tidak berhasil
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      } // Menangani kesalahan umum
    } finally {
      isLoading = false; // Set loading menjadi false setelah selesai
    }
  }

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
      // Ambil nilai created_at
      String? createdAtA = a['created_at'];
      String? createdAtB = b['created_at'];

      // Jika salah satu tanggal adalah null, anggap lebih rendah
      if (createdAtA == null && createdAtB == null) return 0;
      if (createdAtA == null) return isAscending ? 1 : -1;
      if (createdAtB == null) return isAscending ? -1 : 1;

      DateTime dateA = DateTime.parse(createdAtA);
      DateTime dateB = DateTime.parse(createdAtB);
      return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    // Update daftar pengaduan sesuai status
    if (status == 'Belum Selesai') {
      unresolvedComplaints = complaintsToSort;
    } else if (status == 'Sedang Diproses') {
      inProgressComplaints = complaintsToSort;
    } else {
      completedComplaints = complaintsToSort;
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
}
