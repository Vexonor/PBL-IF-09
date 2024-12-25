import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trashify/controllers/complaint/complaint_detail_controller.dart';
import 'package:trashify/services/global_url.dart';

class ComplaintDetail extends StatefulWidget {
  const ComplaintDetail({super.key});

  @override
  State<ComplaintDetail> createState() => _ComplaintDetailState();
}

class _ComplaintDetailState extends State<ComplaintDetail> {
  final ComplaintDetailController controller = ComplaintDetailController();
  bool _hasFetchedData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetchedData) {
      // Ambil argumen dari route
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      controller.setcomplaintId(args['complaintId']);
      fetchComplaintDetails(); // Panggil fetchComplaintDetails di sini
      _hasFetchedData = true; // Set flag setelah data diambil
    }
  }

  Future<void> fetchComplaintDetails() async {
    await controller.fetchComplaintDetails(context);
    if (mounted) {
      setState(() {}); // Update the UI setelah mengambil data
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID')
        .format(dateTime); // Format sesuai keinginan
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/pengaduan', // Ganti dengan nama route yang sesuai
          (Route<dynamic> route) => route.isFirst,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 59, 142, 110),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/pengaduan', // Ganti dengan nama route yang sesuai
                  (Route<dynamic> route) => route.isFirst,
                );
              }
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Detail Pengaduan',
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
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle('Kategori Pengaduan'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.complaintDetails != null
                        ? controller.complaintDetails!['Kategori_Pengaduan']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    _buildTitle('Deskripsi Pengaduan'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.complaintDetails != null
                        ? controller.complaintDetails!['Deskripsi_Pengaduan']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    _buildTitle('Titik Koordinat'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.complaintDetails != null
                        ? controller.complaintDetails!['Titik_Koordinat']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    _buildTitle('Status Pengaduan'),
                    const SizedBox(height: 8),
                    _buildDescription(controller.complaintDetails != null
                        ? controller.complaintDetails!['Status_Pengaduan']
                        : 'Memuat...'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Tanggal Dibuat'),
                            const SizedBox(height: 8),
                            _buildDescriptionDate(controller.complaintDetails !=
                                    null
                                ? formatDate(
                                    controller.complaintDetails!['created_at'])
                                : 'Memuat...'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Tanggal Diperbarui'),
                            const SizedBox(height: 8),
                            _buildDescriptionDate(controller.complaintDetails !=
                                    null
                                ? formatDate(
                                    controller.complaintDetails!['updated_at'])
                                : 'Memuat...'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTitle('Gambar'),
                    const SizedBox(height: 8),
                    controller.complaintDetails != null &&
                            controller.complaintDetails!['Gambar_Pengaduan']
                                is List
                        ? CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              enableInfiniteScroll: false,
                              aspectRatio: 16 / 9,
                              viewportFraction:
                                  0.8, // Mengatur ukuran gambar dalam viewport
                            ),
                            items: (controller
                                        .complaintDetails!['Gambar_Pengaduan']
                                    as List)
                                .map<Widget>((imagePath) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '$imageStorageUrl/$imagePath'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Container(
                            height: 200,
                            child: Center(child: Text('Memuat...')),
                          ),
                    const SizedBox(height: 16),
                    if (controller.complaintDetails != null &&
                        controller.complaintDetails!['Status_Pengaduan'] ==
                            'Belum Selesai') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/edit_pengaduan',
                                arguments: {
                                  'complaintId': controller
                                      .complaintDetails!['ID_Pengaduan']
                                      .toString(),
                                },
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: Text('Edit',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 58, 103, 134),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.showDeleteConfirmationDialog(context);
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: Text('Hapus',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 181, 61, 62),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTitle(String judul) {
    return Text(
      judul,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildDescription(String isi) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isi,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildDescriptionDate(String isi) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        isi,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
