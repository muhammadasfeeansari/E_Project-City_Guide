import 'package:flutter/material.dart';
import 'package:e_project/models/attractionModel.dart'; // Adjust this path based on your structure
import 'package:url_launcher/url_launcher.dart'; // For opening the website link
 // Import LatLng from latlong2 package

class AttractionDetailPage extends StatelessWidget {
  final Attraction attraction;

  const AttractionDetailPage({
    required this.attraction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.name, style:const TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  attraction.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Name and description
              Text(
                attraction.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                attraction.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              // Additional Information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rating: ${attraction.rating}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'Open: ${attraction.openingHours}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Map Placeholder (You can integrate Google Maps here)
              Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(
                  child: Text(
                    'Map Placeholder - Implement Google Maps here',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // User reviews (Placeholder)
              const Text(
                'Reviews',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              // Add a list of reviews or comments here (static for now)
              const Text(
                '• Great place to visit! - 5 Stars',
                style: TextStyle(color: Colors.black54),
              ),
              const Text(
                '• Enjoyed the food. - 4 Stars',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),

              // Link to Website
              ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse(attraction.websiteUrl); // Parse the URL
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch ${attraction.websiteUrl}';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Visit', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}