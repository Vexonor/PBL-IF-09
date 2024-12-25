import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class ComplaintService {
  Future<http.Response> getComplaint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/pengaduan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> getDetailComplaint(String complaintId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/pengaduan/$complaintId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> getEditComplaint(String complaintId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/pengaduan/$complaintId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> storeComplaint(
      String id,
      String category,
      String description,
      String coordinatePoint,
      List<Uint8List>? complaintImageList,
      List<String>? fileNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/pengaduan'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['ID_User'] = id;
    request.fields['Kategori_Pengaduan'] = category;
    request.fields['Deskripsi_Pengaduan'] = description;
    request.fields['Titik_Koordinat'] = coordinatePoint;

    if (complaintImageList != null) {
      for (int i = 0; i < complaintImageList.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'Gambar_Pengaduan[]', // Use array notation for multiple files
          complaintImageList[i],
          filename: fileNames![i],
        ));
      }
    }

    return await request.send().then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  Future<http.Response> updateComplaint(
      String id,
      String category,
      String description,
      String coordinatePoint,
      List<Uint8List>? complaintImageList,
      List<String>? fileNames) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/pengaduan/$id'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['Kategori_Pengaduan'] = category;
    request.fields['Deskripsi_Pengaduan'] = description;
    request.fields['Titik_Koordinat'] = coordinatePoint;

    if (complaintImageList != null) {
      for (int i = 0; i < complaintImageList.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'Gambar_Pengaduan[]', // Use array notation for multiple files
          complaintImageList[i],
          filename: fileNames![i],
        ));
      }
    }

    return await request.send().then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  Future<http.Response> destroyComplaint(String complaintId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$apiUrl/pengaduan/$complaintId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
