import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  int? _userId;
  String? _userName;
  String? _userEmail;
  String? _userNumber;
  String? _userAddress;
  String? _userGender;
  int? _userNik;
  String? _userDateBirth;
  String? _userPhoto;

  int? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userNumber => _userNumber;
  String? get userAddress => _userAddress;
  String? get userGender => _userGender;
  int? get userNik => _userNik;
  String? get userDateBirth => _userDateBirth;
  String? get userPhoto => _userPhoto;

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userId');
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');
    _userNumber = prefs.getString('userNumber');
    _userAddress = prefs.getString('userAddress');
    _userGender = prefs.getString('userGender');
    _userNik = prefs.getInt('userNik');
    _userDateBirth = prefs.getString('userDateBirth');
    _userPhoto = prefs.getString('userPhoto');
  }

  Future<void> saveUserData({
    required int userId,
    required String userNumber,
    required String userAddress,
    required String userGender,
    required int userNik,
    required String userDateBirth,
    required String userPhoto,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userNumber', userNumber);
    await prefs.setString('userAddress', userAddress);
    await prefs.setString('userGender', userGender);
    await prefs.setInt('userNik', userNik);
    await prefs.setString('userDateBirth', userDateBirth);
    await prefs.setString('userPhoto', userPhoto);

    // Perbarui nilai di provider
    _userId = userId;
    _userNumber = userNumber;
    _userAddress = userAddress;
    _userGender = userGender;
    _userNik = userNik;
    _userDateBirth = userDateBirth;
    _userPhoto = userPhoto;

    notifyListeners();
  }

  Future<void> updateUserData({
    required int userId,
    required String userName,
    required String userEmail,
    required int userNik,
    required String userNumber,
    required String userAddress,
    required String userGender,
    required String userDateBirth,
    required String userPhoto,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('userEmail', userEmail);
    await prefs.setString('userNumber', userNumber);
    await prefs.setString('userAddress', userAddress);
    await prefs.setString('userGender', userGender);
    await prefs.setInt('userNik', userNik);
    await prefs.setString('userDateBirth', userDateBirth);
    await prefs.setString('userPhoto', userPhoto);

    // Perbarui nilai di provider
    _userId = userId;
    _userName = userName;
    _userEmail = userEmail;
    _userNumber = userNumber;
    _userAddress = userAddress;
    _userGender = userGender;
    _userNik = userNik;
    _userDateBirth = userDateBirth;
    _userPhoto = userPhoto;

    notifyListeners();
  }

  void resetUserData() {
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userNumber = null;
    _userAddress = null;
    _userGender = null;
    _userNik = null;
    _userDateBirth = null;
    _userPhoto = null;
    notifyListeners();
  }
}
