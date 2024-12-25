// complaint_edit_controller.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:trashify/pages/complaint/additional/select_coordinate.dart';
import 'package:trashify/services/complaint_service.dart';

class ComplaintEditController {
  final ComplaintService service = ComplaintService();
  final TextEditingController complaintDescriptionController =
      TextEditingController();
  final TextEditingController coordinateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  String? complaintId;
  Map<String, dynamic>? editedComplaint;
  LatLng? selectedCoordinate;
  List<XFile>? selectedImages = [];
  List<String>? imageUrl = [];
  String? complaintCategory;
  bool _isLoading = false;
  bool _isProcessing = false;

  bool get isLoading => _isLoading;
  bool get isProcessing => _isProcessing;

  void setLoading(bool value) {
    _isLoading = value;
  }

  void setProcessing(bool value) {
    _isProcessing = value;
  }

  Future<Map<String, dynamic>?> fetchComplaintEditData(
      BuildContext context) async {
    setLoading(true); // Set loading to true

    try {
      if (complaintId != null) {
        final response = await service.getEditComplaint(complaintId!);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else if (response.statusCode == 403) {
          final data = json.decode(response.body);
          if (context.mounted) {
            showSnackBar(context, data['message'],
                const Color.fromARGB(255, 181, 61, 62), 2000);
          }
        } else if (response.statusCode == 404) {
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
      } // Menangani kesalahan umum
    } finally {
      setLoading(false); // Set loading menjadi false setelah selesai
    }
    return null;
  }

  Future<void> loadComplaintData(
      BuildContext context, String complaintId) async {
    this.complaintId = complaintId;
    try {
      final fetchedData = await fetchComplaintEditData(context);
      if (fetchedData != null) {
        editedComplaint = fetchedData; // Assign to the non-final variable
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

  Future<void> openMapToSelectCoordinate(BuildContext context) async {
    LatLng? initialCoordinate;

    if (selectedCoordinate != null) {
      initialCoordinate = selectedCoordinate; // Pass if it exists
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

  Future<void> selectImages(BuildContext context) async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      selectedImages = images;
    }
  }

  Future<void> submitComplaint(
      BuildContext context, Function(bool) setProcessing) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      setProcessing(true); // Set processing to true
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

      setProcessing(false); // Set processing to false

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/detail_pengaduan', // Ganti dengan nama route yang sesuai
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
