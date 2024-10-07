import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trashify/pages/account.dart';
import 'package:trashify/pages/auth/login.dart';
import 'package:trashify/pages/bank.dart';
import 'package:trashify/pages/home.dart';
import 'package:trashify/pages/tps.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Home(),
        '/tps': (context) => Tps(),
        '/bank': (context) => Bank(),
        '/account': (context) => Account(),
      },
      title: 'Trashify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: LogIn(),
    );
  }
}