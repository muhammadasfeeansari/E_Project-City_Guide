import 'package:e_project/helper/helper_func.dart';
import 'package:e_project/pages/login_Page.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final Name = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Register User Function
  void registerUser() async {
    if (formkey.currentState!.validate()) {
      // Show loading dialog
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        // Create user in Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: Email.text, password: Password.text);
        // Store additional user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': Name.text,
          'email': Email.text, // Make sure this is included
          'createdAt': Timestamp.now(),
        });
        // Remove loading dialog
        Navigator.pop(context);
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(
                  Icons
                      .check_circle, // You can change this to any icon you like
                  color: Colors.white,
                ),
                SizedBox(width: 8), // Space between icon and text
                Expanded(
                  child: Text(
                    "Signed up successfully!",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green, // Background color of the SnackBar
            behavior: SnackBarBehavior
                .floating, // Makes the SnackBar appear above the content
            margin: const EdgeInsets.all(16), // Margin around the SnackBar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            duration:
                const Duration(seconds: 3), // Duration the SnackBar is visible
          ),
        );

        // Navigate to Login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayErrorMassage(e.code, context);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to store user data: ${e.toString()}'),
          ),
        );
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

                  // Sign Up Title
                  "Sign Up".text.xl4.bold.make(),

                  const SizedBox(height: 30),
//Name input
                  TextFormField(
                    controller: Name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ).pOnly(bottom: 16),
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
                      hintText: "Enter Your email",
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
                      hintText: "Enter password",
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
                  ).pOnly(bottom: 16),

                  // Confirm Password Input
                  TextFormField(
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value != Password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      prefixIcon: const Icon(Icons.lock),
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
                  ).pOnly(bottom: 30),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: registerUser,
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
                    child: "Sign Up".text.xl.white.bold.make(),
                  ).centered(),

                  const SizedBox(height: 16),

                  // Already have an account? Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Already have an account?".text.gray500.make(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: "Sign In".text.color(Colors.red).bold.make(),
                      ).pOnly(left: 5),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // OR Divider
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: "OR".text.gray500.make(),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ).pSymmetric(v: 16),

                  // Social media sign-up button
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook Icon
                      Icon(
                        FontAwesomeIcons.facebookF,
                        color: Color(0xFF1877F2), // Facebook brand color
                        size: 35, // Icon size
                      ),
                      SizedBox(width: 20), // Space between icons

                      // Google Icon
                      Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFDB4437), // Google's brand color
                        size: 35, // Make size consistent with others
                      ),
                      SizedBox(width: 20), // Space between icons

                      // Twitter Icon (replacing Apple)
                      Icon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xFF1DA1F2), // Twitter's brand color
                        size: 35, // Icon size to match the others
                      ),
                    ],
                  ).centered().pOnly(left: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
