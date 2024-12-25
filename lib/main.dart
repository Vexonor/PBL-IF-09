import 'package:trashify/controllers/main_controller.dart';
import 'package:trashify/pages/education/education_content_edit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trashify/pages/settings/password_setting.dart';
import 'package:trashify/pages/settings/profile_setting.dart';
import 'package:trashify/pages/settings/setting.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/pages/splash_screen.dart';
import 'package:trashify/pages/auth/welcome.dart';
import 'package:trashify/pages/profile.dart';
import 'package:trashify/pages/auth/register.dart';
import 'package:trashify/pages/auth/login.dart';
import 'package:trashify/pages/waste_bank.dart';
import 'package:trashify/pages/home.dart';
import 'package:trashify/pages/education/education.dart';
import 'package:trashify/pages/transportation_information/transportation_information.dart';
import 'package:trashify/pages/tps_information/tps_information.dart';
import 'package:trashify/pages/tps_information/tps_information_detail.dart';
import 'package:trashify/pages/notification.dart';
import 'package:trashify/pages/complaint/complaint.dart';
import 'package:trashify/pages/complaint/complaint_detail.dart';
import 'package:trashify/pages/complaint/complaint_edit.dart';
import 'package:trashify/pages/complaint/complaint_add.dart';
import 'package:trashify/pages/complaint/additional/select_coordinate.dart';
import 'package:trashify/pages/education/education_content_add.dart';
import 'package:trashify/pages/education/education_content.dart';
import 'package:trashify/pages/education/education_content_detail.dart';
import 'package:trashify/pages/education/education_content_gallery.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Memulai aplikasi dengan ChangeNotifierProvider untuk mengelola state user
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider()..loadUserData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trashify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B8E6E)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(), // Menggunakan font Poppins
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en'),
        Locale('id')
      ], // Mendukung bahasa Inggris dan Indonesia
      home: SplashScreen(),
      routes: {
        // Rute untuk autentikasi
        '/masuk': (context) => Login(),
        '/daftar': (context) => Register(),
        '/pembuka': (context) => Welcome(),
        // '/pembuka_pengguna': (context) => Welcome(),
        // Rute untuk fitur utama
        '/halaman_utama': (context) => MainPage(),
        '/notifikasi': (context) => NotificationCenter(),
        // Rute untuk pengaduan
        '/pengaduan': (context) => Complaint(),
        '/tambah_pengaduan': (context) => ComplaintAdd(),
        '/detail_pengaduan': (context) => ComplaintDetail(),
        '/edit_pengaduan': (context) => ComplaintEdit(),
        '/pilih_koordinat': (context) => SelectCoordinate(),
        // Rute untuk informasi pengangkutan
        '/informasi_pengangkutan': (context) => TransportationInformation(),
        // Rute untuk edukasi
        '/edukasi': (context) => Education(),
        '/konten_edukasi': (context) => EducationContent(),
        '/tambah_konten_edukasi': (context) => EducationContentAdd(),
        '/galeri_konten_edukasi': (context) => EducationContentGallery(),
        '/detail_konten_edukasi': (context) => EducationContentDetail(),
        '/edit_konten_edukasi': (context) => EducationContentEdit(),
        // Rute untuk lokasi TPS
        '/informasi_tps': (context) => TpsInformation(),
        '/detail_informasi_tps': (context) => TpsInformationDetail(),
        // Rute untuk Pengaturan
        '/pengaturan': (context) => Setting(),
        '/Pengaturan_Profil': (context) => ProfileSetting(),
        '/Pengaturan_password': (context) => PasswordSetting(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController controller = MainController();
  int _selectedIndex = 0; // Indeks halaman yang dipilih
  final List<Widget> _pages = const [
    Home(), // Halaman Beranda
    TpsInformation(), // Halaman Lokasi TPS
    WasteBank(), // Halaman Bank Sampah
    Akun() // Halaman Akun
  ];

  @override
  void initState() {
    super.initState();
    controller.checkUserLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          _navItem(Icons.home, "Beranda",
              _selectedIndex == 0), // Item navigasi untuk Beranda
          _navItem(Icons.location_on, "Informasi TPS",
              _selectedIndex == 1), // Item navigasi untuk Lokasi TPS
          _navItem(Icons.account_balance, "Bank Sampah",
              _selectedIndex == 2), // Item navigasi untuk Bank Sampah
          _navItem(Icons.person, "Akun",
              _selectedIndex == 3), // Item navigasi untuk Akun
        ],
        height: 60, // Tinggi navigasi
        backgroundColor: Colors.transparent, // Warna latar belakang transparan
        color: const Color.fromARGB(255, 59, 142, 110), // Warna item navigasi
        onTap: (index) => setState(() => _selectedIndex =
            index), // Mengubah halaman saat item navigasi ditekan
      ),
    );
  }

  // Fungsi untuk membuat item navigasi
  Widget _navItem(IconData icon, String label, bool isSelected) {
    return SizedBox(
      width: 100, // Lebar item navigasi
      height: 50, // Tinggi item navigasi
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.white), // Ikon item navigasi
          Text(
            isSelected
                ? label.replaceAll(" ", "\n")
                : label, // Menampilkan label dengan pemformatan
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10), // Menggunakan font Poppins untuk label
            textAlign: TextAlign.center,
            maxLines: isSelected ? 2 : 1, // Mengatur jumlah baris label
            overflow: TextOverflow.ellipsis, // Mengatur overflow teks
          ),
        ],
      ),
    );
  }
}
