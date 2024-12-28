import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:trashify/controllers/main_controller.dart';
import 'package:trashify/pages/auth/login.dart';
import 'package:trashify/pages/auth/register.dart';
import 'package:trashify/pages/auth/welcome.dart';
import 'package:trashify/pages/complaint/additional/select_coordinate.dart';
import 'package:trashify/pages/complaint/complaint.dart';
import 'package:trashify/pages/complaint/complaint_add.dart';
import 'package:trashify/pages/complaint/complaint_detail.dart';
import 'package:trashify/pages/complaint/complaint_edit.dart';
import 'package:trashify/pages/education/education.dart';
import 'package:trashify/pages/education/education_content.dart';
import 'package:trashify/pages/education/education_content_add.dart';
import 'package:trashify/pages/education/education_content_detail.dart';
import 'package:trashify/pages/education/education_content_edit.dart';
import 'package:trashify/pages/education/education_content_gallery.dart';
import 'package:trashify/pages/home.dart';
import 'package:trashify/pages/notification.dart';
import 'package:trashify/pages/profile.dart';
import 'package:trashify/pages/settings/general_setting.dart';
import 'package:trashify/pages/settings/password_setting.dart';
import 'package:trashify/pages/settings/profile_setting.dart';
import 'package:trashify/pages/settings/setting.dart';
import 'package:trashify/pages/settings/terms_condition.dart';
import 'package:trashify/pages/transportation_information/transportation_area.dart';
import 'package:trashify/pages/transportation_information/transportation_information.dart';
import 'package:trashify/pages/tps_information/tps_information.dart';
import 'package:trashify/pages/tps_information/tps_information_detail.dart';
import 'package:trashify/providers/user_provider.dart';
import 'package:trashify/pages/splash_screen.dart';
import 'package:trashify/pages/waste_bank.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      home: SplashScreen(),
      routes: {
        // Rute untuk autentikasi
        '/masuk': (context) => Login(),
        '/daftar': (context) => Register(),
        '/pembuka': (context) => Welcome(),
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
        '/detail_informasi_pengangkutan': (context) => TransportationArea(
              selectedDate: DateTime.now(),
              coordinates: LatLng(1, 1),
              idWorker: '',
              transportationTime: '',
            ),
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
        '/pengaturan_Profil': (context) => ProfileSetting(),
        '/pengaturan_password': (context) => PasswordSetting(),
        '/pengaturan_umum': (context) => GeneralSetting(),
        '/syarat_ketentuan': (context) => TermsCondition(),
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
    Profile() // Halaman Akun
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
          _navItem(Icons.home, "Beranda", _selectedIndex == 0),
          _navItem(Icons.location_on, "Informasi TPS", _selectedIndex == 1),
          _navItem(Icons.account_balance, "Bank Sampah", _selectedIndex == 2),
          _navItem(Icons.person, "Akun", _selectedIndex == 3),
        ],
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 59, 142, 110),
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  // Fungsi untuk membuat item navigasi
  Widget _navItem(IconData icon, String label, bool isSelected) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          Text(
            isSelected ? label.replaceAll(" ", "\n") : label,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: isSelected ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
