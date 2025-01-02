import 'package:flutter/material.dart';
import 'package:renuka_travels/dbHelper/mongodb.dart';
import 'package:flutter_html/flutter_html.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Map<String, String>>>(
        future: MongoDatabase.getDestinationCard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No destinations found.'),
            );
          } else {
            final destinations = snapshot.data!;
            final currentDestination = destinations[_currentIndex];
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the destination name at the top
                  Text(
                    currentDestination['destinationName'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display the destination image in the middle
                  currentDestination['destImage'] != null
                      ? Image.network(
                          currentDestination['destImage']!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  // Display the description below the image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Html(data: currentDestination['description'] ?? ''),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
