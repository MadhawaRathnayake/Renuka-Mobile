import 'package:flutter/material.dart';
import 'package:renuka_travels/components/destinations_card.dart';
import 'package:renuka_travels/dbHelper/mongodb.dart';

class Destinations extends StatefulWidget {
  const Destinations({super.key});

  @override
  State<Destinations> createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations> {
  late Future<List<String>> _destinationNames;
  late ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _destinationNames = MongoDatabase.getDestinationNames();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index, List<String> destinations) {
    const double itemWidth =
        60.0; // Approximate width of each item, including padding
    final double scrollPosition = index * itemWidth;

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinations"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            DestinationCard(currentIndex: _currentIndex),
            FutureBuilder<List<String>>(
              future: _destinationNames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  final destinations = snapshot.data!;
                  return Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_left),
                          onPressed: () {
                            setState(() {
                              if (_currentIndex > 0) {
                                _currentIndex--;
                                _scrollToIndex(_currentIndex, destinations);
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(destinations.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = index;
                                      _scrollToIndex(index, destinations);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      destinations[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _currentIndex == index
                                            ? Colors.deepPurple
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            setState(() {
                              if (_currentIndex < destinations.length - 1) {
                                _currentIndex++;
                                _scrollToIndex(_currentIndex, destinations);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
