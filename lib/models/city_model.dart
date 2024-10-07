class City {
  final int id;
  final String name;
  final String desc;
  final List<String> images;

  City({required this.id, required this.name, required this.desc, required this.images});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      images: List<String>.from(json['images']),
    );
  }
}
