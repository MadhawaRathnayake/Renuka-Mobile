import 'package:flutter/material.dart';
import 'package:renuka_travels/dbHelper/mongodb.dart';
import 'package:renuka_travels/pages/TourDetailsPage.dart';

class TourPage extends StatefulWidget {
  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  List<Map<String, dynamic>> tours = [];
  bool isLoading = true;
  final String defaultImageUrl =
      'https://ichef.bbci.co.uk/images/ic/1024xn/p0b7n6dm.jpg.webp';

  @override
  void initState() {
    super.initState();
    fetchTours();
  }

  Future<void> fetchTours() async {
    try {
      await MongoDatabase.connect(); // Ensure MongoDB connection
      final data = await MongoDatabase.getTourCards(); // Fetch tours
      if (mounted) {
        setState(() {
          tours = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching tours: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildTourImage(String? imageUrl) {
    // If URL is empty or null or contains example.com, use default image
    if (imageUrl == null ||
        imageUrl.isEmpty ||
        imageUrl.contains('example.com')) {
      imageUrl = defaultImageUrl;
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      height: 150, // Fixed height for consistency
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        // On any error, fall back to default image
        return Image.network(
          defaultImageUrl,
          fit: BoxFit.cover,
          height: 150,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            // If even default image fails, show error container
            return Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.grey[600], size: 40),
                  SizedBox(height: 4),
                  Text(
                    'No image',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: 150,
          width: double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tours')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tours.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No tours available'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchTours,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchTours,
                  child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75, // Adjusted for better card layout
                    ),
                    itemCount: tours.length,
                    itemBuilder: (context, index) {
                      final tour = tours[index];
                      return Card(
                        clipBehavior:
                            Clip.antiAlias, // Ensures clean image edges
                        elevation: 2,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TourDetailsPage(tourId: tour['_id']),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTourImage(tour['photo']),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tour['title'] ?? 'Untitled Tour',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${tour['days']} Days',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
