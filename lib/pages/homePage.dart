import 'package:e_project/models/city_model.dart';
import 'package:e_project/services.dart/city_service.dart';
import 'package:e_project/themes/mythme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
 // Assuming your theme is defined here

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<City> _allCities = []; // List to store all cities
  List<City> _filteredCities = []; // List for filtered cities
  String _searchQuery = ''; // To track the search input

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    List<City> cities = await fetchCities();
    setState(() {
      _allCities = cities;
      _filteredCities = cities; // Initially, all cities are displayed
    });
  }

  void _filterCities(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCities = _allCities; // Show all cities if query is empty
      } else {
        _filteredCities = _allCities
            .where((city) =>
                city.name.toLowerCase().contains(query.toLowerCase())) // Case-insensitive match
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mytheme.creamcolor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: 'Explore Cities'
            .text
            .color(mytheme.creamcolor)
            .fontFamily('')
            .size(25)
            .bold
            .make(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              bool? shouldLogout = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(false), // Cancel action
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(true), // Confirm action
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout ?? false) {
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
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context); // Dismiss the loading indicator
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  Navigator.pop(context); // Dismiss on error
                  print("Error signing out: $e");
                }
              }
            },
            icon: const Icon(
              Icons.logout_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          headerSection(onSearchChanged: _filterCities), // Pass the search function to header
          Expanded(
            child: _filteredCities.isNotEmpty
                ? CityListView(cities: _filteredCities)
                : const Center(child: Text('No city found')), // Show "No city found" if empty
          ),
        ],
      ),
      drawer: const Drawer(),
    );
  }
}

// Header Section with Search Bar
class headerSection extends StatelessWidget {
  final Function(String) onSearchChanged;
  const headerSection({required this.onSearchChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome!\nChoose a city to explore:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: onSearchChanged, // Call the function when text changes
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.search,
                  color: Colors.redAccent,
                ),
                border: InputBorder.none,
                hintText: 'Search cities...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// City List View
class CityListView extends StatelessWidget {
  final List<City> cities;
  const CityListView({required this.cities, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return CityCard(city: city); // Create a card for each city
      },
    );
  }
}

// City Card Widget
class CityCard extends StatelessWidget {
  final City city;
  const CityCard({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the first image of the city with a stylish effect
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                Image.network(
                  city.images[0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Gradient overlay to make the text more readable
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // City name with bold styling
                Text(
                  city.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    letterSpacing: 1.2, // Gives more professional spacing
                  ),
                ),
                const SizedBox(height: 6),
                // City description with enhanced readability
                Text(
                  city.desc,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5, // Better line height for clarity
                  ),
                ),
                const SizedBox(height: 12),
                // Custom button with a red theme for "Explore" or any CTA
                ElevatedButton(
                  onPressed: () {
                    // Action to explore the city details
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

