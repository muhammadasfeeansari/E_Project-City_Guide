import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Ensure this is imported
import 'package:latlong2/latlong.dart'; // Import LatLng from the correct package
import 'package:e_project/models/attractionModel.dart';
import 'package:url_launcher/url_launcher.dart'; // Adjust this path based on your structure

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
        title:
            Text(attraction.name, style: const TextStyle(color: Colors.white)),
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

              // Map Container
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
                style: TextStyle(
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
                  // Parse the URL from the attraction object
                  Uri url = Uri.parse(attraction.websiteUrl);

                  // Check if the URL can be launched
                  if (await canLaunchUrl(url)) {
                    // Launch the URL in the user's default browser
                    await launchUrl(url);
                  } else {
                    // Handle the case where the URL cannot be launched (optional)
                    throw 'Could not launch ${attraction.websiteUrl}';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child:
                    const Text('Visit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
