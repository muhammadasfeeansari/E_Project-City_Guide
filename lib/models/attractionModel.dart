class Attraction {
  final String name;
  final String description;
  final String imageUrl;
  final String openingHours;
  final double rating;

  Attraction({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.openingHours,
    required this.rating,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      openingHours: json['openingHours'],
      rating: json['rating'].toDouble(),
    );
  }
}
