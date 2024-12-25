import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/pages/complaint/additional/select_coordinate.dart';
import 'package:trashify/services/complaint_service.dart';

class ComplaintAddController {
  final ComplaintService service = ComplaintService();
  final TextEditingController complaintDescriptionController =
      TextEditingController();
  final TextEditingController coordinateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  bool imageValidatorError = false;
  bool isProcessing = false;
  int? userId;
  LatLng? selectedCoordinate;
  String? complaintCategory = 'Pengangkutan Sampah';
  String? imageValidator;
  List<XFile>? selectedImages = [];

  ComplaintAddController() {
    init();
  }

  Future<void> init() async {
    await _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
  }

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

  Future<void> selectImages(BuildContext context) async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      selectedImages = images;
    }
  }

  bool validateForm() {
    bool isValid = formKey.currentState!.validate();
    if (selectedImages!.isEmpty) {
      isValid = false;
      imageValidator = 'Gambar Pengaduan wajib diupload';
      imageValidatorError = true;
    }
    return isValid;
  }

  Future<void> submitComplaint(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      isProcessing = true;

      List<Uint8List> imageBytesList = [];
      List<String> fileNames = [];

      for (var image in selectedImages!) {
        Uint8List imageBytes = await image.readAsBytes();
        imageBytesList.add(imageBytes);
        fileNames.add(image.name);
      }

      final response = await service.storeComplaint(
        userId.toString(),
        complaintCategory ?? 'Lainnya',
        complaintDescriptionController.text,
        coordinateController.text,
        imageBytesList,
        fileNames,
      );

      try {
        if (response.statusCode == 201) {
          final data = json.decode(response.body);
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/pengaduan',
              (Route<dynamic> route) => route.isFirst,
            );
            if (context.mounted) {
              showSnackBar(context, data['message'],
                  Color.fromARGB(255, 59, 142, 110), 2000);
            }
          }
        } else if (response.statusCode == 500) {
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
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, 'Terjadi kesalahan, silakan coba lagi!',
              const Color.fromARGB(255, 181, 61, 62), 2000);
        }
      } finally {
        isProcessing = false;
      }
    }
  }

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
