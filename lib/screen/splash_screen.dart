import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:gimix/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any initialization tasks here if needed
    _navigateToHomeScreen();
  }

  void _navigateToHomeScreen() {
    // Simulate a delay of 2 seconds to show the splash screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5433FF), // Purple
                  Color(0xFF20BDFF), // Blue
                  Color(0xFFA5FECB), // Light Green
                  // Colors.black87,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Lottie.asset(
                'assets/images/animation_splash.json', // Replace with your Lottie animation file path
                height: 200,
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.yellow, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: const Text(
                'By \nNazri Arwadi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
