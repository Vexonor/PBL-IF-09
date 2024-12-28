import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class EducationService {
  // Mengambil konten edukasi
  Future<http.Response> getEducationContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/konten_edukasi'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menampilkan konten edukasi berdasarkan ID
  Future<http.Response> showEducationContent(int educationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/konten_edukasi/$educationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menampilkan galeri konten edukasi berdasarkan ID pengguna
  Future<http.Response> showEducationContentGalery(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/konten_edukasi/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menampilkan detail konten edukasi berdasarkan ID
  Future<http.Response> showEducationContentDetail(int educationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/konten_edukasi/detail/$educationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menampilkan konten edukasi untuk diedit berdasarkan ID
  Future<http.Response> showEducationContentEdit(int educationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$apiUrl/konten_edukasi/detail/$educationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // Menyimpan konten edukasi baru
  Future<http.Response> storeEducationContent(
    String userId,
    String contentTitle,
    String contentLink,
    String contentDescription,
    String contentType,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/konten_edukasi'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['ID_User'] = userId;
    request.fields['Judul_Edukasi'] = contentTitle;
    request.fields['Link_URL'] = contentLink;
    request.fields['Deskripsi_Edukasi'] = contentDescription;
    request.fields['Jenis_Edukasi'] = contentType;

    return await request.send().then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  // Memperbarui konten edukasi berdasarkan ID
  Future<http.Response> updateEducationContent(
    int educationId,
    String contentTitle,
    String contentLink,
    String contentDescription,
    String contentType,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/konten_edukasi/$educationId'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields['Judul_Edukasi'] = contentTitle;
    request.fields['Link_URL'] = contentLink;
    request.fields['Deskripsi_Edukasi'] = contentDescription;

    return await request.send().then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  // Menghapus konten edukasi berdasarkan ID
  Future<http.Response> destroyEducationContent(int educationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$apiUrl/konten_edukasi/$educationId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
