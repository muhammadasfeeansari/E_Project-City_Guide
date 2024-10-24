import 'package:e_project/models/attractionModel.dart';
import 'package:e_project/models/city_model.dart';
import 'package:e_project/pages/attractionPage.dart';
import 'package:e_project/pages/drawerPage.dart';
import 'package:e_project/pages/profilePage.dart';
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
            .where((city) => city.name
                .toLowerCase()
                .contains(query.toLowerCase())) // Case-insensitive match
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (context.theme.canvasColor),
      appBar: AppBar(
        backgroundColor: mytheme.blueishcolor,
        title: 'Explore Cities'
            .text
            .color(Colors.white)
            .fontFamily('')
            .size(25)
            .bold
            .make(),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body: Column(
        children: [
          headerSection(
              onSearchChanged:
                  _filterCities), // Pass the search function to header
          Expanded(
            child: _filteredCities.isNotEmpty
                ? CityListView(cities: _filteredCities)
                : const Center(
                    child:
                        Text('No city found')), // Show "No city found" if empty
          ),
        ],
      ),
      drawer: const Drawerpage(),
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
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              onSearchChanged(value);
            },
            decoration: InputDecoration(
              hintText: 'Search Cities Where You Want To Go ',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xff403b58)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Vx.indigo500),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
        return CityCard(
          city: city,
          attractions: const [],
        ); // Create a card for each city
      },
    );
  }
}

// City Card Widget
class CityCard extends StatelessWidget {
  final City city;
  final List<Attraction> attractions; // Pass attractions related to this city

  const CityCard({required this.city, required this.attractions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mytheme.blueishcolor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // City image
          if (city.images != null && city.images.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: Image.network(
                city.images[0],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          else
            const SizedBox(
              height: 180,
              child: Center(child: Text('No image available')),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // City name
                Text(
                  city.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: (Theme.of(context).textTheme.displayLarge?.color ??
                        mytheme.blueishcolor),
                  ),
                ),
                const SizedBox(height: 8),
                // City description
                Text(
                  city.desc ??
                      'No description available', // Use city description
                  style: TextStyle(
                    fontSize: 16,
                    color: (Theme.of(context).textTheme.displayLarge?.color ??
                        mytheme.blueishcolor),
                  ),
                ),
                const SizedBox(height: 12),
                // Explore button
                ElevatedButton(
                  onPressed: () async {
                    List<Attraction> attractions =
                        await getAttractionsForCity(city.name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttractionListPage(
                          cityName: city.name,
                          attractions:
                              attractions, // Pass the relevant attractions
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (context).theme.canvasColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
