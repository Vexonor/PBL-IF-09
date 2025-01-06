import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/services/global_url.dart';

class AccountService {
  // Fungsi untuk mendaftar akun baru
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

  // Fungsi untuk mendapatkan informasi verifikasi kode
  Future<http.Response> getVerification(String idUser) async {
    final response = await http.get(
      Uri.parse('$apiUrl/verifikasi/$idUser'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  // Fungsi untuk verifikasi kode
  Future<http.Response> verification(String code, String userId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/verifikasi/$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'Kode_Otp': code}),
    );
    return response;
  }

  // Fungsi untuk mengirim ulang kode
  Future<http.Response> resendOtp(String userId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/kirim_ulang_otp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'ID_User': userId}),
    );
    return response;
  }

  // Fungsi untuk login ke akun
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

  // Fungsi untuk menyimpan data pengguna
  Future<http.Response> saveUserData(
    String id,
    String nik,
    String number,
    String address,
    String birthDate,
    String gender,
    Uint8List? profilePhoto,
    String? fileName,
  ) async {
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

    request.fields['ID_User'] = id;
    request.fields['Alamat'] = address;
    request.fields['Jenis_Kelamin'] = gender;
    request.fields['Nik'] = nik;
    request.fields['No_Telp'] = number;
    request.fields['Tanggal_Lahir'] = birthDate;

    if (profilePhoto != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Foto_Profil',
        profilePhoto,
        filename: fileName ?? 'image.jpg',
      ));
    }

    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  // Fungsi untuk memperbarui data pengguna
  Future<http.Response> updateUserData(
    String id,
    String nama,
    String email,
    String nik,
    String number,
    String address,
    String birthDate,
    String gender,
    Uint8List? profilePhoto,
    String? fileName,
  ) async {
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

    request.fields['Alamat'] = address;
    request.fields['Jenis_Kelamin'] = gender;
    request.fields['Nik'] = nik;
    request.fields['No_Telp'] = number;
    request.fields['Tanggal_Lahir'] = birthDate;
    request.fields['Nama'] = nama;
    request.fields['email'] = email;

    if (profilePhoto != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Foto_Profil',
        profilePhoto,
        filename: fileName ?? 'image.jpg',
      ));
    }

    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  // Fungsi untuk memperbarui kata sandi pengguna
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

    request.fields['Kata_Sandi_Lama'] = oldPassword;
    request.fields['Kata_Sandi_Baru'] = newPassword;

    var response = await request.send();
    return await http.Response.fromStream(response);
  }
}
