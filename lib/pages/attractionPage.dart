import 'package:e_project/pages/attractionDetailedPage.dart';
import 'package:flutter/material.dart';
import 'package:e_project/models/attractionModel.dart';

class AttractionListPage extends StatefulWidget {
  final String cityName;
  final List<Attraction> attractions;

  const AttractionListPage({
    required this.cityName,
    required this.attractions,
    Key? key,
  }) : super(key: key);

  @override
  _AttractionListPageState createState() => _AttractionListPageState();
}

class _AttractionListPageState extends State<AttractionListPage> {
  String searchQuery = '';
  List<Attraction> filteredAttractions = [];

  @override
  void initState() {
    super.initState();
    filteredAttractions = widget.attractions; // Initialize with all attractions
  }

  void filterAttractions(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredAttractions = widget.attractions; // Show all attractions
      });
    } else {
      setState(() {
        filteredAttractions = widget.attractions
            .where((attraction) =>
                attraction.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attractions in ${widget.cityName}',
          style: const TextStyle(color: Colors.white),
        ),
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

            // Search Box
            TextField(
              onChanged: (value) {
                filterAttractions(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Hotels, Restuarants And Events Here ',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
            // const SizedBox(height: 12),

            // // Best Hotels section
            // const Text(
            //   'Best Hotels',
            //   style: TextStyle(
            //       fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            // ),
            const SizedBox(height: 12),

            // Hotels list
            Expanded(
              child: ListView.builder(
                itemCount: filteredAttractions.length,
                itemBuilder: (context, index) {
                  final attraction = filteredAttractions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionDetailPage(
                            attraction: attraction,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth,
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
                                    style:
                                        const TextStyle(color: Colors.black54),
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
                                        'Open: ${attraction.openingHours}',
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
