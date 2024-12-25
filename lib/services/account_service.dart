import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class AccountService {
  Future<http.Response> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/daftar'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'Nama': name,
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> verification(String code) async {
    final response = await http.post(Uri.parse('$apiUrl/verification'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'code': code}));
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/masuk'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> saveUserData(
      String id,
      String nik,
      String nomor,
      String alamat,
      String tanggalLahir,
      String jenisKelamin,
      Uint8List? fotoProfil,
      String? fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/pembuka'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // Menambahkan field ke request
    request.fields['ID_User'] = id;
    request.fields['No_Telp'] = nomor;
    request.fields['Alamat'] = alamat;
    request.fields['Tanggal_Lahir'] = tanggalLahir;
    request.fields['Jenis_Kelamin'] = jenisKelamin;
    request.fields['Nik'] = nik;

    // Menambahkan file gambar jika ada
    if (fotoProfil != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Foto_Profil',
        fotoProfil,
        filename: fileName ?? 'image.jpg',
      ));
    }

    // Mengirim request
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<http.Response> updateUserData(
      String id,
      String nama,
      String email,
      String nik,
      String nomor,
      String alamat,
      String tanggalLahir,
      String jenisKelamin,
      Uint8List? fotoProfil,
      String? fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/ubah_profil/$id'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // Menambahkan field ke request
    request.fields['Nama'] = nama;
    request.fields['email'] = email;
    request.fields['No_Telp'] = nomor;
    request.fields['Alamat'] = alamat;
    request.fields['Tanggal_Lahir'] = tanggalLahir;
    request.fields['Jenis_Kelamin'] = jenisKelamin;
    request.fields['Nik'] = nik;

    // Menambahkan file gambar jika ada
    if (fotoProfil != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Foto_Profil',
        fotoProfil,
        filename: fileName ?? 'image.jpg',
      ));
    }

    // Mengirim request
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<http.Response> updateUserPassword(
    String id,
    String oldPassword,
    String newPassword,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/ubah_kata_sandi/$id'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    // Menambahkan field ke request
    request.fields['Kata_Sandi_Lama'] = oldPassword;
    request.fields['Kata_Sandi_Baru'] = newPassword;

    // Mengirim request
    var response = await request.send();
    return await http.Response.fromStream(response);
  }
}
