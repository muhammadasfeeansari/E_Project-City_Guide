import 'package:e_project/pages/homePage.dart';
import 'package:e_project/pages/login_Page.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  // function
  void checkUserLoggedIn() async {
  // Wait for 2 seconds (simulate splash screen delay)
  await Future.delayed(const Duration(seconds: 2));

  // Check if user is logged in
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is logged in, navigate to Home Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>const Homepage()),
    );
  } else {
    // User is not logged in, navigate to Login Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>const LoginPage()),
    );
  }
}

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animation duration
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller); // Scale animation

    // Start the animations
    _controller.forward();

    // Timer to navigate to the next page
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/register'); // Change to your next route
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mytheme.creamcolor, // Background color
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Splash logo or image with BoxFit to adjust its size
                Image.asset(
                  'assets/images/file.png', // Ensure the image path is correct
                  fit: BoxFit.cover, // Adjusts the image to fill the space
                  height: 200, // Set a fixed height if needed
                  width: 200,  // Set a fixed width if needed
                ),
                const SizedBox(height: 5), // Space between logo and text
                "City Guide"
                    .text
                    .fontFamily('cursive')
                    .extraBold
                    .size(25)
                    .xl5
                    .color(Colors.red)
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
