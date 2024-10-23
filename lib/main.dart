import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashify/pages/akun.dart';
import 'package:trashify/pages/auth/masuk.dart';
import 'package:trashify/pages/bank_sampah.dart';
import 'package:trashify/pages/beranda.dart';
import 'package:trashify/pages/lokasi_tps.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trashify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 59, 142, 110)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('id'),
      ],
      home: const Masuk(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Beranda(),
    const LokasiTps(),
    const BankSampah(),
    const Akun()
  ];
  final List<Widget> _items = [
    SizedBox(
      width: 50,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.home, size: 20, color: Colors.white),
          const Padding(padding: EdgeInsets.only(bottom: 3)),
          Text(
            "Beranda",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    ),
    SizedBox(
      width: 100,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.location_on, size: 20, color: Colors.white),
          const Padding(padding: EdgeInsets.only(bottom: 3)),
          Text(
            "Lokasi TPS",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    ),
    SizedBox(
      width: 100,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.account_balance, size: 20, color: Colors.white),
          const Padding(padding: EdgeInsets.only(bottom: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Bank Sampah",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    ),
    SizedBox(
      width: 50,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.person, size: 20, color: Colors.white),
          const Padding(padding: EdgeInsets.only(bottom: 3)),
          Text(
            "Akun",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: _items,
        height: 60,
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(255, 59, 142, 110),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
