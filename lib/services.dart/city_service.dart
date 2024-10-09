import 'dart:convert';
import 'package:e_project/models/city_model.dart';
import 'package:flutter/services.dart' show rootBundle; // Ensure to import this to load the JSON
// Import your City model
import 'package:e_project/models/attractionModel.dart'; // Import your Attraction model

// Function to fetch cities from the JSON file
Future<List<City>> fetchCities() async {
  final String response = await rootBundle.loadString('assets/files/cities.json');
  final data = json.decode(response);
  return (data['Cities'] as List).map((city) => City.fromJson(city)).toList();
}

// Function to get attractions for a specific city
Future<List<Attraction>> getAttractionsForCity(String cityName) async {
  // Fetch the cities
  List<City> cities = await fetchCities();

  // Find the city and return its attractions
  for (var city in cities) {
    if (city.name == cityName) {
      return city.attractions; // Return the list of attractions
    }
  }

  return []; 
}
