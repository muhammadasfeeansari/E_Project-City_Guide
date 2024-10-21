class Attraction {
  final String name;
  final String description;
  final String imageUrl;
  final String openingHours;
  final double rating;
  final String websiteUrl;
  final double latitude;   // New field for latitude
  final double longitude;  // New field for longitude

  Attraction({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.openingHours,
    required this.rating,
    required this.websiteUrl,
    required this.latitude,  // Initialize latitude
    required this.longitude, // Initialize longitude
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      openingHours: json['openingHours'],
      rating: json['rating'].toDouble(),
      websiteUrl: json['websiteUrl'],
      latitude: json['latitude'].toDouble(),  // Parse latitude
      longitude: json['longitude'].toDouble(), // Parse longitude
    );
  }
}
