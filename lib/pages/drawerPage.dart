import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_project/pages/profilePage.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:e_project/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Drawerpage extends StatelessWidget {
  const Drawerpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the currently logged-in user
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    // If the user is logged in, get their email and UID, otherwise use default guest values
    String userEmail = user?.email ?? "guest@example.com";
    String userId = user?.uid ?? '';

    return Drawer(
      child: Container(
        color: context.theme.canvasColor, // Using your existing color
        child: Column(
          children: [
            // Fetch user data from Firestore and display it in the Drawer header
            FutureBuilder<DocumentSnapshot>(
              future: _firestore.collection('users').doc(userId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: mytheme.blueishcolor,
                    ),
                    accountName: const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    accountEmail: const Text(
                      "guest@example.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png",
                      ),
                    ),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                  return UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: mytheme.blueishcolor,
                    ),
                    accountName: const Text(
                      "Guest",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    accountEmail: const Text(
                      "guest@example.com",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png",
                      ),
                    ),
                  );
                }

                // User data is fetched, display the name and email
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                String username = userData['username'] ?? "No Name"; // Fetch the username from Firestore

                return UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: mytheme.blueishcolor, // Your custom blueish color
                  ),
                  accountName: Text(
                    username, // Display the username fetched from Firestore
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    userEmail, // Display the user's email
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png",
                    ),
                  ),
                );
              },
            ),

            // Drawer Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Profile Tile
                  ListTile(
                    leading: Icon(Icons.person, color: mytheme.creamcolor),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                        color: mytheme.creamcolor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),

                  // Email Tile
                  // ListTile(
                  //   leading: Icon(Icons.app_registration_outlined,
                  //       color: mytheme.creamcolor),
                  //   title: Text(
                  //     "Sign Up",
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       color: mytheme.creamcolor,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     // Handle email action
                  //   },
                  // ),

                  // Login Tile with InkWell for ripple effect
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    child: ListTile(
                      leading: Icon(Icons.login, color: mytheme.creamcolor),
                      title: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: mytheme.creamcolor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Logout Button at the Bottom
          ListTile(
  leading: const Icon(
    Icons.logout_outlined,
    size: 30,
    color: Colors.white,
  ),
  title: const Text(
    'Logout',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
  ),
  onTap: () async {
    // Show confirmation dialog
    bool? shouldLogout = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // If user confirms sign-out
    if (shouldLogout ?? false) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await FirebaseAuth.instance.signOut(); // Firebase logout
        Navigator.pop(context); // Dismiss loading indicator
        Navigator.pushReplacementNamed(context, '/login'); // Navigate to login
      } catch (e) {
        Navigator.pop(context); // Dismiss loading on error
        print("Error signing out: $e");
      }
    }
  },
),

          ],
        ),
      ),
    );
  }
}
