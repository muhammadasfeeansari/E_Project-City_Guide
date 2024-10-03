import 'package:e_project/firebase_options.dart';
import 'package:e_project/pages/forgetPassword_page.dart';
import 'package:e_project/pages/homePage.dart';
import 'package:e_project/pages/login_Page.dart';
import 'package:e_project/pages/registration_Page.dart';
import 'package:e_project/pages/splashScreen.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:e_project/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme.lightTheme(context),
      initialRoute: "/splashscreen",
      routes: {
        MyRoutes.splashRoute: (context) => const SplashscreenPage(),
        MyRoutes.registrationRoute: (context) => const RegistrationPage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.forgetpasswordRoute: (context) => const ForgetPasswordPage(),
        MyRoutes.homeRoute: (context) => const Homepage(),
      },
    );
  }
}
