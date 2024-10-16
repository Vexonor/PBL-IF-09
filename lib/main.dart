import 'package:flutter/material.dart';
import 'package:trashify/pages/akun.dart';
import 'package:trashify/pages/auth/masuk.dart';
import 'package:trashify/pages/bank_sampah.dart';
import 'package:trashify/pages/beranda.dart';
import 'package:trashify/pages/lokasi_tps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/beranda': (context) => const Beranda(),
        '/lokasi_tps': (context) => const LokasiTps(),
        '/bank_sampah': (context) => const BankSampah(),
        '/akun': (context) => const Akun(),
      },
      title: 'Trashify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 59, 142, 110)),
        useMaterial3: true,
      ),
      home: const Masuk(),
    );
  }
}
