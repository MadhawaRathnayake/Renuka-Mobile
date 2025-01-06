import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renuka_travels/dbHelper/mongodb.dart';

class TourDetailsPage extends StatefulWidget {
  final String tourId;

  const TourDetailsPage({Key? key, required this.tourId}) : super(key: key);

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  Map<String, dynamic>? tourDetails;
  bool isLoading = true;
  String? errorMessage;
  final String defaultImageUrl =
      'https://ichef.bbci.co.uk/images/ic/1024xn/p0b7n6dm.jpg.webp';

  @override
  void initState() {
    super.initState();
    fetchTourDetails();
  }

  Future<void> fetchTourDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await MongoDatabase.connect();
      final details = await MongoDatabase.getTourById(widget.tourId);

      if (mounted) {
        setState(() {
          tourDetails = details;
          isLoading = false;
          if (details == null) {
            errorMessage = 'Tour not found';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load tour details';
          isLoading = false;
        });
      }
      print('Error in fetchTourDetails: $e');
    }
  }

  Future<bool> checkImageUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking image URL: $e');
      return false;
    }
  }

  Widget _buildImage(String? imageUrl) {
    // If URL is empty or null, use default image immediately
    if (imageUrl == null ||
        imageUrl.isEmpty ||
        imageUrl.contains('example.com')) {
      imageUrl = 'https://ichef.bbci.co.uk/images/ic/1024xn/p0b7n6dm.jpg.webp';
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // On any error, fall back to default image
        return Image.network(
          'https://ichef.bbci.co.uk/images/ic/1024xn/p0b7n6dm.jpg.webp',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // If even default image fails, show error container
            return Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.grey[600], size: 40),
                  SizedBox(height: 8),
                  Text('Image not available',
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            );
          },
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: double.infinity,
          height: 200,
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
      appBar: AppBar(title: Text('Tour Details')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchTourDetails,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchTourDetails,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildImage(tourDetails!['photo']),
                          SizedBox(height: 10),
                          Text(
                            tourDetails!['title'],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('Days: ${tourDetails!['days']}'),
                          SizedBox(height: 10),
                          Text('Description: ${tourDetails!['desc']}'),
                          SizedBox(height: 10),
                          Text('Destinations:'),
                          ...List.generate(
                            tourDetails!['destinations'].length,
                            (index) => Text(
                                '- ${tourDetails!['destinations'][index]}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
