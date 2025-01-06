import 'package:mongo_dart/mongo_dart.dart';
import 'package:renuka_travels/dbHelper/constant.dart';

class MongoDatabase {
  static var db, destinationCollection, tourCollection;
  static bool isConnected = false;

  // Establish connection to MongoDB
  static connect() async {
    if (isConnected) return;

    try {
      db = await Db.create(MONGO_CONN_URL);
      await db.open();
      destinationCollection = db.collection("destinations");
      tourCollection = db.collection("tours"); // New collection for tours
      isConnected = true;
    } catch (e) {
      print('MongoDB connection error: $e');
      rethrow;
    }
  }

  // Fetch Destination Names
  static Future<List<String>> getDestinationNames() async {
    try {
      final arrData = await destinationCollection
          .find()
          .map((doc) => doc['destinationName'] as String)
          .toList();
      return List<String>.from(arrData);
    } catch (e) {
      print('Error fetching destination names: $e');
      return [];
    }
  }

  // Fetch Destination Cards
  static Future<List<Map<String, String>>> getDestinationCard() async {
    try {
      final cardData = await destinationCollection.find().map((doc) {
        return {
          'destinationName': doc['destinationName'] as String? ?? '',
          'destImage': doc['destImage'] as String? ?? '',
          'description': doc['description'] as String? ?? '',
        };
      }).toList();
      return List<Map<String, String>>.from(cardData);
    } catch (e) {
      print('Error fetching destination cards: $e');
      return [];
    }
  }

  // Fetch Tour Cards
  static Future<List<Map<String, dynamic>>> getTourCards() async {
    try {
      final tourData = await tourCollection.find().map((doc) {
        return {
          '_id': doc['_id'].toString(), // Convert ObjectId to String
          'title': doc['title'] as String? ?? 'Untitled Tour',
          'photo': doc['photo'] as String? ?? '',
          'desc': doc['desc'] as String? ?? '',
          'days': doc['days'] as int? ?? 0,
        };
      }).toList();
      return List<Map<String, dynamic>>.from(tourData);
    } catch (e) {
      print('Error fetching tour cards: $e');
      return [];
    }
  }

  // Fetch Detailed Tour by ID
  static Future<Map<String, dynamic>?> getTourById(String id) async {
    try {
      // Clean the ID string if it's wrapped with ObjectId() (e.g., ObjectId("..."))
      id = id.replaceAll('ObjectId("', '').replaceAll('")', '');

      // Try to convert the cleaned string to ObjectId
      ObjectId tourId;
      try {
        tourId = ObjectId.fromHexString(id); // Ensure this is a valid ObjectId
      } catch (e) {
        print('Invalid ObjectId format: $id');
        return null; // Return null if the format is invalid
      }

      // Fetch the tour data from MongoDB using the ObjectId
      final tour = await tourCollection.findOne(where.eq('_id', tourId));

      if (tour != null) {
        // Map the MongoDB result to a Dart Map
        return {
          '_id': tour['_id']
              .toString(), // Convert ObjectId to string here if needed
          'title': tour['title'] as String? ?? 'Untitled Tour',
          'photo':
              tour['photo'] as String? ?? '', // Default to empty string if null
          'desc': tour['desc'] as String? ?? '',
          'destinations': List<String>.from(
              tour['destinations'] ?? []), // Ensure list is not null
          'days': tour['days'] as int? ?? 0,
          'createdAt': tour['createdAt'],
          'updatedAt': tour['updatedAt'],
        };
      }

      return null; // Return null if tour not found
    } catch (e) {
      print('Error fetching tour: $e');
      return null;
    }
  }
}
