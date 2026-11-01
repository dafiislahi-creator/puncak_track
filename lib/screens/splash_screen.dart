
import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color green = Color(0xFF195C27);

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              height: constraints.maxHeight,
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // Logo aplikasi
                  Container(
                    width: 112,
                    height: 112,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.landscape_outlined,
                      size: 67,
                      color: green,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Nama aplikasi
                  const Text(
                    'PUNCAK TRACK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Slogan
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Jelajahi alam, nikmati perjalanan,\ndan tetap aman di setiap langkah.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFDCEEDC),
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Loading
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Mempersiapkan perjalananmu...',
                    style: TextStyle(
                      color: Color(0xFFDCEEDC),
                      fontSize: 11,
                    ),
                  ),

                  const Spacer(flex: 1),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'VERSION 1.0.0',
                      style: TextStyle(
                        color: Color(0xFFB9D1BA),
                        fontSize: 9,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
