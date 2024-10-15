class Event {
  final String name;
  final String description;
  final String imageUrl;
  final String date;
  final String time;
  final String location;

  Event({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }
}
