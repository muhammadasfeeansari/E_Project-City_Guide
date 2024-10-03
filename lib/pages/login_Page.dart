import 'package:e_project/helper/helper_func.dart';
import 'package:e_project/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:e_project/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Email = TextEditingController();
  final Password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void loginUser() async {
    if (formkey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: Email.text, password: Password.text);
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        // error massage for the user
        displayErrorMassage(e.code, context);
      }
    }
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mytheme.creamcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo at the top
                  Center(
                    child: "City Guide"
                        .text
                        .fontFamily('cursive')
                        .extraBold
                        .size(25)
                        .xl5
                        .color(Colors.red)
                        .make(),
                  ),

                  const SizedBox(height: 40),

                  // Login Title
                  "Login".text.xl4.bold.make(),

                  const SizedBox(height: 30),

                  // Email Input
                  TextFormField(
                    controller: Email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@gmail.com')) {
                        return 'Please enter a valid Gmail address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      filled: true,
                      prefixIcon: const Icon(Icons.email),
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).pOnly(bottom: 16),

                  // Password Input
                  TextFormField(
                    controller: Password,
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      } else if (value.length <= 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).pOnly(bottom: 8),
                  const SizedBox(
                    height: 10,
                  ),
                  // Forget Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MyRoutes.forgetpasswordRoute);
                      },
                      child: "Forget Password?".text.color(Colors.red).make(),
                    ),
                  ).pOnly(bottom: 30),

                  // Login Button
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 80.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: "Login".text.xl.white.bold.make(),
                  ).centered(),

                  const SizedBox(height: 16),

                  // Don't have an account? Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Don't have an account?".text.gray500.make(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MyRoutes.registrationRoute);
                        },
                        child: "Sign Up".text.color(Colors.red).bold.make(),
                      ).pOnly(left: 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
