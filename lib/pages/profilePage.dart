import 'package:e_project/themes/mythme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  String? _imageUrl;

  // Form fields for editing
  String? _username;
  String? _email;
  String? _phone;
  String? _address;

  bool _isEditing = false; // To toggle between view and edit modes

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('No user logged in'));
    }

    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(
        backgroundColor: mytheme.blueishcolor,
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveProfile(user);
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Profile not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          // Set user data for fields
          _username = userData['username'];
          _email = userData['email'];
          _phone = userData['phone'];
          _address = userData['address'];
          _imageUrl = userData['imageUrl']; // Fetch stored image URL

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Profile Picture with Image Picker
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!) as ImageProvider
                              : (_imageUrl != null
                                  ? NetworkImage(_imageUrl!)
                                  : const NetworkImage(
                                      'https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png')),
                          backgroundColor: Colors.grey[200],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.grey),
                            onPressed: _pickImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Username Field
                  TextFormField(
                    initialValue: _username,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _username = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                  ),
                  const SizedBox(height: 20),

                  // Email Field (non-editable)
                  TextFormField(
                    initialValue: _email,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Phone Field
                  TextFormField(
                    initialValue: _phone,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _phone = value,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a valid phone number'
                        : null,
                  ),
                  const SizedBox(height: 20),

                  // Address Field
                  TextFormField(
                    initialValue: _address,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _address = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an address' : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Image Picker function
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      await _uploadImageToFirebase(_auth.currentUser!);
    }
  }

  // Upload image to Firebase Storage
  Future<void> _uploadImageToFirebase(User user) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${user.uid}.jpg');
      await ref.putFile(_pickedImage!);
      final url = await ref.getDownloadURL();

      // Update the user's profile with the image URL
      await _firestore.collection('users').doc(user.uid).update({
        'imageUrl': url,
      });

      setState(() {
        _imageUrl = url;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  // Save profile to Firestore
  Future<void> _saveProfile(User user) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _firestore.collection('users').doc(user.uid).update({
          'username': _username,
          'phone': _phone,
          'address': _address,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }
}
