import 'package:flutter/material.dart';
import 'package:e_project/models/attractionModel.dart';

class AttractionListPage extends StatelessWidget {
  final String cityName;
  final List<Attraction> attractions;

  const AttractionListPage(
      {required this.cityName, required this.attractions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Attractions in $cityName',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            const Text(
              'Explore Attractions',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 12),

            // Filter and Sort Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement filtering logic here
                  },
                  child: const Text('Filter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement sorting logic here
                  },
                  child: const Text('Sort'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Attractions list
            Expanded(
              child: ListView.builder(
                itemCount: attractions.length,
                itemBuilder: (context, index) {
                  final attraction = attractions[index];
                  return Container(
                    width: screenWidth, // Full width
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.network(
                              attraction.imageUrl,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  attraction.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  attraction.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rating: ${attraction.rating}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                    Text(
                                      'Open: ${attraction.openingHours}', // Assuming this is a property of Attraction
                                      style: const TextStyle(
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
