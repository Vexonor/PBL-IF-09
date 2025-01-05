import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/pages/complaint/additional/select_coordinate.dart';
import 'package:trashify/services/complaint_service.dart';

class ComplaintEditController {
  final ComplaintService service = ComplaintService();
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController complaintDescriptionController =
      TextEditingController();
  final TextEditingController coordinateController = TextEditingController();

  bool _isLoading = false;
  bool _isProcessing = false;
  bool get isLoading => _isLoading;
  bool get isProcessing => _isProcessing;
  LatLng? selectedCoordinate;
  List<String>? imageUrl = [];
  List<XFile>? selectedImages = [];
  Map<String, dynamic>? editedComplaint;
  String? complaintCategory;
  String? complaintId;

  void setLoading(bool value) {
    _isLoading = value;
  }

  void setProcessing(bool value) {
    _isProcessing = value;
  }

  // Mengambil data pengaduan untuk diedit
  Future<Map<String, dynamic>?> fetchComplaintEditData(
      BuildContext context) async {
    setLoading(true);
    try {
      if (complaintId != null) {
        final response = await service.getEditComplaint(complaintId!);
        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else if (response.statusCode == 403 || response.statusCode == 404) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        } else {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
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
      setLoading(false);
    }
    return null;
  }

  // Memuat data pengaduan berdasarkan ID
  Future<void> loadComplaintData(
      BuildContext context, String complaintId) async {
    this.complaintId = complaintId;
    try {
      final fetchedData = await fetchComplaintEditData(context);
      if (fetchedData != null) {
        editedComplaint = fetchedData;
        complaintCategory = editedComplaint!['Kategori_Pengaduan'];
        complaintDescriptionController.text =
            editedComplaint!['Deskripsi_Pengaduan'];
        coordinateController.text = editedComplaint!['Titik_Koordinat'];
        imageUrl = List<String>.from(editedComplaint!['Gambar_Pengaduan']);

        String? coordinateString = editedComplaint!['Titik_Koordinat'];
        if (coordinateString != null && coordinateString.isNotEmpty) {
          List<String> parts = coordinateString.split(',');
          if (parts.length == 2) {
            double latitude = double.tryParse(parts[0].trim()) ?? 0.0;
            double longitude = double.tryParse(parts[1].trim()) ?? 0.0;
            selectedCoordinate = LatLng(latitude, longitude);
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
            const Color.fromARGB(255, 181, 61, 62), 2000);
      }
    }
  }

  // Membuka peta untuk memilih koordinat
  Future<void> openMapToSelectCoordinate(BuildContext context) async {
    LatLng? initialCoordinate;
    if (selectedCoordinate != null) {
      initialCoordinate = selectedCoordinate;
    }

    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SelectCoordinate(initialCoordinate: initialCoordinate),
      ),
    );

    if (result != null) {
      selectedCoordinate = result;
      coordinateController.text = '${result.latitude}, ${result.longitude}';
    }
  }

// Mengambil beberapa foto dari kamera
  Future<void> takeMultiplePicturesFromCamera(BuildContext context) async {
    List<XFile> images = [];
    bool continueTakingPhotos = true;

    while (continueTakingPhotos) {
      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (image != null) {
        images.add(image);
        // Tampilkan dialog untuk menanyakan apakah ingin mengambil foto lagi
        if (context.mounted) {
          continueTakingPhotos = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Ambil Foto Lagi?'),
                    content: Text('Apakah Anda ingin mengambil foto lagi?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tidak'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Ya'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              ) ??
              false;
        }
      } else {
        continueTakingPhotos = false;
      }
    }

    if (images.isNotEmpty) {
      selectedImages = images;
    }
  }

  // Memilih gambar dari galeri
  Future<void> selectImages(BuildContext context,
      {bool fromCamera = false}) async {
    if (fromCamera) {
      await takeMultiplePicturesFromCamera(context);
    } else {
      final List<XFile> images = await picker.pickMultiImage();
      selectedImages = images;
    }
  }

  // Mengirim pengaduan yang telah diedit
  Future<void> submitComplaint(
      BuildContext context, Function(bool) setProcessing) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      setProcessing(true);
      List<Uint8List>? imageBytesList = [];
      List<String>? fileNames = [];

      if (selectedImages != null) {
        for (var image in selectedImages!) {
          Uint8List imageBytes = await image.readAsBytes();
          imageBytesList.add(imageBytes);
          fileNames.add(image.name);
        }
      } else if (imageUrl != null) {
        imageBytesList = null;
        fileNames = null;
      }

      String category = complaintCategory ?? 'Lainnya';
      String description = complaintDescriptionController.text;
      String coordinate = coordinateController.text;

      final response = await service.updateComplaint(
        editedComplaint!['ID_Pengaduan'].toString(),
        category,
        description,
        coordinate,
        imageBytesList,
        fileNames,
      );

      setProcessing(false);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/detail_pengaduan',
            (Route<dynamic> route) =>
                route.isFirst || route.settings.name == '/pengaduan',
            arguments: {
              'complaintId': complaintId.toString(),
            },
          );
        }
        if (context.mounted) {
          showSnackBar(context, data['message'],
              Color.fromARGB(255, 59, 142, 110), 2000);
        }
      } else {
        final data = json.decode(response.body);
        if (context.mounted) {
          showSnackBar(context, data['message'],
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      }
    }
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
