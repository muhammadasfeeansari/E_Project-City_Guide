import 'dart:convert';
import 'package:e_project/models/city_model.dart';
import 'package:flutter/services.dart';


Future<List<City>> fetchCities() async {
  final String response = await rootBundle.loadString('assets/files/cities.json');
  final data = json.decode(response);
  return (data['Cities'] as List).map((city) => City.fromJson(city)).toList();
}
