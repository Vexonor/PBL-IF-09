import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/controllers/complaint/complaint_controller.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final ComplaintController controller = ComplaintController();

  bool isCompletedAscending = false; // Mengurutkan pengaduan yang sudah selesai
  bool isInProgressAscending =
      false; // Mengurutkan pengaduan yang sedang diproses
  bool isUnresolvedAscending =
      false; // Mengurutkan pengaduan yang belum selesai

  @override
  void initState() {
    super.initState();
    controller.getCurrentUserId(context).then((_) {
      setState(() {}); // Memperbarui UI setelah memuat data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (mounted) {
              Navigator.pushNamed(context, '/halaman_utama');
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Pengaduan',
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
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unresolved Complaints Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Belum Selesai',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isUnresolvedAscending = !isUnresolvedAscending;
                              controller.sortComplaintsByCreatedAt(
                                  'Belum Selesai', isUnresolvedAscending);
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: isUnresolvedAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: !isUnresolvedAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller.unresolvedScrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: controller.unresolvedComplaints.isEmpty
                            ? Center(
                              child: SingleChildScrollView(
                                controller:
                                      controller.unresolvedScrollController,
                                child: Text(
                                  'Tidak ada Pengaduan yang Belum Selesai',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            : ListView.builder(
                          controller: controller.unresolvedScrollController,
                          itemCount: controller.unresolvedComplaints.length,
                          itemBuilder: (context, index) {
                            return _complaintItem(
                              controller.unresolvedComplaints[index]
                                  ['ID_Pengaduan'],
                              controller.unresolvedComplaints[index]
                                  ['Kategori_Pengaduan'],
                              controller.unresolvedComplaints[index]
                                  ['Deskripsi_Pengaduan'],
                              controller.unresolvedComplaints[index]
                                  ['Titik_Koordinat'],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sedang Diproses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isInProgressAscending = !isInProgressAscending;
                              controller.sortComplaintsByCreatedAt(
                                  'Sedang Diproses', isInProgressAscending);
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: isInProgressAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: !isInProgressAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller.inProgressScrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: controller.inProgressComplaints.isEmpty
                            ? Center(
                              child: SingleChildScrollView(
                                controller:
                                      controller.inProgressScrollController,
                                child: Text(
                                  'Tidak ada Pengaduan yang Sedang Diproses',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            : ListView.builder(
                          controller: controller.inProgressScrollController,
                          itemCount: controller.inProgressComplaints.length,
                          itemBuilder: (context, index) {
                            return _complaintItem(
                              controller.inProgressComplaints[index]
                                  ['ID_Pengaduan'],
                              controller.inProgressComplaints[index]
                                  ['Kategori_Pengaduan'],
                              controller.inProgressComplaints[index]
                                  ['Deskripsi_Pengaduan'],
                              controller.inProgressComplaints[index]
                                  ['Titik_Koordinat'],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sudah Selesai',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isCompletedAscending = !isCompletedAscending;
                              controller.sortComplaintsByCreatedAt(
                                  'Sudah Selesai', isCompletedAscending);
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: isCompletedAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: !isCompletedAscending
                                      ? Color.fromARGB(255, 59, 142, 110)
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller.completedScrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: controller.completedComplaints.isEmpty
                            ? Center(
                              child: SingleChildScrollView(
                                controller:
                                      controller.completedScrollController,
                                child: Text(
                                  'Tidak ada Pengaduan yang Sudah Selesai',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            : ListView.builder(
                          controller: controller.completedScrollController,
                          itemCount: controller.completedComplaints.length,
                          itemBuilder: (context, index) {
                            return _complaintItem(
                              controller.completedComplaints[index]
                                  ['ID_Pengaduan'],
                              controller.completedComplaints[index]
                                  ['Kategori_Pengaduan'],
                              controller.completedComplaints[index]
                                  ['Deskripsi_Pengaduan'],
                              controller.completedComplaints[index]
                                  ['Titik_Koordinat'],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tambah_pengaduan');
        },
        backgroundColor: const Color.fromARGB(255, 59, 142, 110),
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              const Icon(Icons.edit, color: Colors.white),
              Text(
                'Buat Aduan',
                style: TextStyle(
                  fontSize: 6,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan item pengaduan
  Widget _complaintItem(
      int id, String category, String description, String coordinate) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(Icons.article, color: Colors.grey[700]),
        title: Text(
          'Pengaduan: $category',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/detail_pengaduan',
            arguments: {
              'complaintId': id.toString(),
            },
          );
        },
      ),
    );
  }
}
