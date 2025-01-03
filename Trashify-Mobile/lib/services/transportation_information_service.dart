import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class TransportationInformationService {
  // Mengambil informasi transportasi
  Future<http.Response> getTransportationInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/informasi_pengangkutan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Mengambil informasi petugas berdasarkan ID
  Future<http.Response> getWorkerInformation(String idPetugas) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/informasi_pengangkutan/$idPetugas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
