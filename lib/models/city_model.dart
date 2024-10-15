import 'package:e_project/models/EventModel.dart';
import 'package:e_project/models/HotelModel.dart';
import 'package:e_project/models/RestaurantModel.dart';
import 'package:e_project/models/attractionModel.dart';

class City {
  final int id;
  final String name;
  final String desc;
  final List<String> images;
  final List<Attraction> attractions;
  final List<Hotel> hotels;
  final List<Restaurant> restaurants;
  final List<Event>events ; // Add this line

  City({
    required this.id,
    required this.name,
    required this.desc,
    required this.images,
    required this.attractions,
    required this.hotels,
     required this.restaurants,
      required this.events, // Add this line
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      images: List<String>.from(json['images']),
      attractions: (json['attractions'] as List)
          .map((attraction) => Attraction.fromJson(attraction))
          .toList(), hotels: [], restaurants: [], events: [], // Add this line to convert JSON to Attraction objects
    );
  }
}
