import 'package:flutter/material.dart';
import 'package:renuka_travels/dbHelper/mongodb.dart';
import 'package:renuka_travels/dbHelper/mongodb_model.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<GalleryModel>> _galleryData;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _galleryData = MongoDatabase.getGalleryImages();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<GalleryModel>>(
        future: _galleryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No images available'),
            );
          }

          // Calculate the number of pages based on the length of the gallery data
          int pageCount = (snapshot.data!.length / 6).ceil();

          return Column(
            children: [
              // Image Grid in Pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pageCount,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    int startIndex = pageIndex * 6;
                    int endIndex = startIndex + 6;
                    List<GalleryModel> pageItems = snapshot.data!.sublist(
                      startIndex,
                      endIndex > snapshot.data!.length
                          ? snapshot.data!.length
                          : endIndex,
                    );

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // 2 columns for 6 images (2 columns, 3 rows)
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            1, // Keeps square aspect ratio for images
                      ),
                      itemCount: pageItems.length,
                      itemBuilder: (context, index) {
                        final galleryItem = pageItems[index];
                        return Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            galleryItem.imageURL,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  size: 32,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Page Navigation Controls
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                    Text(
                      'Page ${_currentPage + 1}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: _currentPage < pageCount - 1
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
