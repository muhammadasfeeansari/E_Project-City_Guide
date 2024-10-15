class Hotel {
  final String name;
  final String description;
  final String imageUrl;
  final String openingHours;
  final double rating;

  Hotel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.openingHours,
    required this.rating,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      openingHours: json['openingHours'],
      rating: json['rating'].toDouble(),
    );
  }
}
