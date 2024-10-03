import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:e_project/themes/mythme.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final Email = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

// Function to send reset password email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              SizedBox(width: 8), // Space between icon and text
              Expanded(
                child: Text(
                  "Email sent successfully. Please check your inbox.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
              const Duration(seconds: 5), // Duration the SnackBar is visible
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: ${e.message}", // Show error message in SnackBar
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red, // Background color for error
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
  // forgot password function End Here !

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

                  // Forget Password Title
                  "Forgot Password".text.xl4.bold.make(),

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

                  // Reset Password Button
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        sendPasswordResetEmail(Email
                            .text); // Passing the email from the TextFormField
                      }
                    },
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
                    child: "Send Email".text.xl.white.bold.make(),
                  ).centered(),

                  const SizedBox(height: 16),

                  // Back to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Remember your password?".text.gray500.make(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Navigate back to login page
                        },
                        child: "Login".text.color(Colors.red).bold.make(),
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
