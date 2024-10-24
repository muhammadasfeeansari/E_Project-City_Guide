import 'package:e_project/themes/mythme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Ensure this is imported
import 'package:latlong2/latlong.dart'; // Import LatLng from the correct package
import 'package:e_project/models/attractionModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart'; // Adjust this path based on your structure

class AttractionDetailPage extends StatelessWidget {
  final Attraction attraction;

  const AttractionDetailPage({
    required this.attraction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (context).theme.canvasColor,
      appBar: AppBar(
        title: Text(attraction.name,
            style: TextStyle(
                color: (Theme.of(context).textTheme.displayLarge?.color ??
                    mytheme.blueishcolor))),
        backgroundColor: mytheme.blueishcolor,
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: (Theme.of(context).textTheme.displayLarge?.color ??
                      mytheme.blueishcolor),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                attraction.description,
                style: TextStyle(
                  fontSize: 16,
                  color: (Theme.of(context).textTheme.displayLarge?.color ??
                      mytheme.blueishcolor),
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
                    style: TextStyle(
                        color:
                            (Theme.of(context).textTheme.displayLarge?.color ??
                                mytheme.blueishcolor)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Map Container
              // Map Placeholder (You can integrate Google Maps here)
              Container(
                height: 200,
                color: mytheme.creamcolor,
                child: Center(
                  child: FlutterMap(
                      options:  MapOptions(
                        initialCenter: LatLng(attraction.latitude, attraction.longitude),
                        initialZoom: 13,
                        interactionOptions:const InteractionOptions(
                            flags: ~InteractiveFlag.doubleTapZoom),
                      ),
                      children: [
                        openStreetMapTileLayer,
                         MarkerLayer(markers: [
                          Marker(
                              point: LatLng(attraction.latitude, attraction.longitude ),
                              width: 80,
                              height: 80,
                              alignment: Alignment.centerLeft,
                              child:const Icon(
                                Icons.location_pin,
                                size: 40,
                                color: Colors.red,
                              ))
                        ])
                      ]),
                ),
              ),
              const SizedBox(height: 16),

              // User reviews (Placeholder)
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (Theme.of(context).textTheme.displayLarge?.color ??
                      mytheme.blueishcolor),
                ),
              ),
              const SizedBox(height: 8),
              // Add a list of reviews or comments here (static for now)
              Text(
                '• Great place to visit! - 5 Stars',
                style: TextStyle(
                    color: (Theme.of(context).textTheme.displayLarge?.color ??
                        mytheme.blueishcolor)),
              ),
              Text(
                '• Enjoyed the food. - 4 Stars',
                style: TextStyle(
                    color: (Theme.of(context).textTheme.displayLarge?.color ??
                        mytheme.blueishcolor)),
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
                  backgroundColor: mytheme.blueishcolor,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text('Visit Site',
                    style: TextStyle(
                        color:
                            (Theme.of(context).textTheme.displayLarge?.color ??
                                mytheme.blueishcolor))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'http://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
