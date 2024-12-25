import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trashify/pages/complaint/complaint_add.dart';
import 'package:trashify/services/tps_information_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TpsInformationDetailController {
  final TpsInformationService service = TpsInformationService();
  List<dynamic>? tpsInformationDetail;
  String? district;

  // Method to set the district
  void setDistrict(String district) {
    this.district = district;
  }

  Future<void> fetchTpsInformationDetail(
      BuildContext context, Function(bool) setLoading) async {
    setLoading(true); // Start loading

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

  void showBottomSheet(
      BuildContext context,
      List<Map<String, dynamic>> sortedTpsList,
      String? selectedTpsCode,
      Function(String) onSelect) {
    // Urutkan TPS sehingga yang dipilih muncul di atas
    List<Map<String, dynamic>> displayList = [];
    if (selectedTpsCode != null) {
      final selectedTps = sortedTpsList.firstWhere(
          (tps) => tps['Kode_TPS'] == selectedTpsCode,
          orElse: () => {} // Return an empty map if not found
          );
      if (selectedTps.isNotEmpty) {
        displayList.add(selectedTps); // Tambahkan TPS yang dipilih di atas
        sortedTpsList.remove(selectedTps);
      }
    }
    displayList.addAll(sortedTpsList);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize
              .min, // Mengatur ukuran kolom agar sesuai dengan konten
          children: [
            const Divider(
                thickness: 5,
                indent: 150,
                endIndent: 150), // Menambahkan Divider di atas
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final tps = displayList[index];

                    bool isSelected = selectedTpsCode == tps['Kode_TPS'];

                    return GestureDetector(
                      onTap: () {
                        onSelect(tps['Kode_TPS']);
                        Navigator.pop(context);
                      },
                      child: Card(
                        elevation: 5,
                        color: isSelected
                            ? Color.fromARGB(255, 59, 142, 110)
                            : Colors.white,
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(8.0), // Padding untuk ikon
                            child: const Icon(Icons.location_on,
                                color: Color.fromARGB(255, 181, 61, 62)),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode TPS: ${tps['Kode_TPS']}',
                                  style: isSelected
                                      ? TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)
                                      : null),
                              Text('Titik Koordinat: ${tps['Titik_Koordinat']}',
                                  style: isSelected
                                      ? TextStyle(
                                          color: Colors.white, fontSize: 12)
                                      : TextStyle(fontSize: 12)),
                              Text('Status TPS: ${tps['Status_TPS']}',
                                  style: isSelected
                                      ? TextStyle(
                                          color: Colors.white, fontSize: 12)
                                      : TextStyle(fontSize: 12)),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton pertama dengan latar belakang belah ketupat
                              Transform.rotate(
                                angle: 45 *
                                    3.141592653589793238 /
                                    180, // Memutar 45 derajat
                                child: Container(
                                  width: 35, // Lebar latar belakang
                                  height: 35, // Tinggi latar belakang
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 58, 103,
                                        134), // Warna latar belakang
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        8), // Sudut membulat
                                  ),
                                  child: Transform.rotate(
                                    angle: -45 * 3.141592653589793238 / 180,
                                    child: IconButton(
                                      icon: const Icon(Icons.copy,
                                          color: Colors.white), // Warna ikon
                                      iconSize: 16,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Pilih Aksi'),
                                              content: Text(
                                                  'Apa yang ingin Anda lakukan dengan koordinat ini?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    // Menyalin koordinat ke clipboard
                                                    Clipboard.setData(ClipboardData(
                                                        text: tps[
                                                            'Titik_Koordinat']));
                                                    showSnackBar(
                                                        context,
                                                        'Koordinat disalin ke clipboard',
                                                        const Color.fromARGB(
                                                            255, 58, 103, 134),
                                                        2000);
                                                    Navigator.of(context)
                                                        .pop(); // Tutup dialog
                                                  },
                                                  child:
                                                      Text('Salin Koordinat'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Membuka koordinat di Google Maps
                                                    final String url =
                                                        'https://www.google.com/maps/search/?api=1&query=${tps['Titik_Koordinat']}';
                                                    launchUrlString(
                                                        url); // Pastikan Anda mengimpor package url_launcher
                                                    Navigator.of(context)
                                                        .pop(); // Tutup dialog
                                                  },
                                                  child: Text(
                                                      'Buka di Google Maps'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      12), // Jarak antara icon buttons // IconButton kedua dengan latar belakang belah ketupat
                              Transform.rotate(
                                angle: 45 *
                                    3.141592653589793238 /
                                    180, // Memutar 45 derajat
                                child: Container(
                                  width: 35, // Lebar latar belakang
                                  height: 35, // Tinggi latar belakang
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 181, 61,
                                        62), // Warna latar belakang
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        8), // Sudut membulat
                                  ),
                                  child: Transform.rotate(
                                    angle: -45 * 3.141592653589793238 / 180,
                                    child: IconButton(
                                      icon: const Icon(Icons.warning,
                                          color: Colors.white), // Warna ikon
                                      iconSize: 16,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ComplaintAdd(
                                              initialCategory: 'Kondisi TPS',
                                              initialCoordinates:
                                                  tps['Titik_Koordinat'],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
