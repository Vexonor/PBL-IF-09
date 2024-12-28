import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class CommentService {
  // Mengambil semua komentar
  Future<http.Response> getComment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/komentar'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menampilkan komentar berdasarkan ID pendidikan
  Future<http.Response> showComment(int educationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/komentar/$educationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menyimpan komentar baru
  Future<http.Response> storeComment(
    String educationId,
    String userId,
    String comment,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/komentar'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['ID_Edukasi'] = educationId;
    request.fields['ID_User'] = userId;
    request.fields['Isi_Komentar'] = comment;

    return await request.send().then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  // Menghapus komentar berdasarkan indeks
  Future<http.Response> destroyComment(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$apiUrl/komentar/$index'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
