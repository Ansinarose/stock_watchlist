import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_watchlist/screens/home_screen.dart';  // Import your home screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()), // Navigate to HomeScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize background color
      body: Center(
       child: Image.asset('assets/images/logo.jpg', height: 80, width: 80), // Splash logo image
      ),
    );
  }
}
