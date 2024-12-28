import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class TpsInformationService {
  // Mengambil detail informasi TPS berdasarkan kecamatan
  Future<http.Response> getTpsInformationDetail(String kecamatan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/lokasi_tps/$kecamatan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
