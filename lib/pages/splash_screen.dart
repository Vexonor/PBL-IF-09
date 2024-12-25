import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashify/main.dart';
import 'package:trashify/pages/auth/login.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/splash_screen.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            // Tambahkan waktu tunggu sebelum memeriksa status login
            _checkUserLoginStatus();
          }
        });
      });
  }

  Future<void> _checkUserLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString('token');

    if (session != null) {
      // Jika session ada, arahkan ke halaman utama dengan transisi fade-in
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Mengatur fade-in effect
              const begin = 0.0;
              const end = 1.0;
              const curve =
                  Curves.easeInOut; // Menggunakan curve yang lebih halus

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var opacityAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: opacityAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 700),
          ),
        );
      }
    } else {
      // Jika session tidak ada, arahkan ke halaman login dengan transisi fade-in
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Login(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Mengatur fade-in effect
              const begin = 0.0;
              const end = 1.0;
              const curve =
                  Curves.easeInOut; // Menggunakan curve yang lebih halus

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var opacityAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: opacityAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 700),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: double.infinity, // Menggunakan lebar penuh
                height: double.infinity, // Menggunakan tinggi penuh
                child: FittedBox(
                  fit: BoxFit
                      .cover, // Menggunakan BoxFit.cover untuk mengisi seluruh layar
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
