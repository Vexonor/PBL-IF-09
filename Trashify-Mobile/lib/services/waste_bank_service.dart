import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class WasteBankService {
  // Mengambil data bank sampah berdasarkan jenis sampah
  Future<http.Response> getWasteBank(String jenisSampah) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/bank_sampah/$jenisSampah'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
