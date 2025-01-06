import 'package:mongo_dart/mongo_dart.dart';
import 'package:renuka_travels/dbHelper/constant.dart';
import 'package:renuka_travels/dbHelper/mongodb_model.dart';

class MongoDatabase {
  static var db, destinationCollection, galleryCollection;

  static connect() async {
    try {
      db = await Db.create(MONGO_CONN_URL);
      await db.open();
      destinationCollection = db.collection("destinations");
      galleryCollection = db.collection("galleries");
      print("Connected to MongoDB!");
    } catch (e) {
      print("Error connecting to MongoDB: $e");
    }
  }

  static Future<List<String>> getDestinationNames() async {
    try {
      final arrData = await destinationCollection
          .find()
          .map((doc) => doc['destinationName'] as String)
          .toList();
      return List<String>.from(arrData);
    } catch (e) {
      print("Error fetching destination names: $e");
      return [];
    }
  }

  static Future<List<Map<String, String>>> getDestinationCard() async {
    try {
      final cardData = await destinationCollection.find().map((doc) {
        return {
          'destinationName': doc['destinationName'] as String,
          'destImage': doc['destImage'] as String,
          'description': doc['description'] as String,
        };
      }).toList();
      return List<Map<String, String>>.from(cardData);
    } catch (e) {
      print("Error fetching destination cards: $e");
      return [];
    }
  }

  static Future<List<GalleryModel>> getGalleryImages() async {
    try {
      print("MongoDB connection state: ${db.state}");

      var cursor = galleryCollection.find();
      var galleryData = await cursor.toList();
      print("Raw gallery data: $galleryData");

      if (galleryData.isEmpty) {
        print("No gallery data found");
        return [];
      }

      List<GalleryModel> galleryItems = [];
      for (var doc in galleryData) {
        try {
          print("Processing document: $doc");
          var model = GalleryModel.fromJson(doc);
          galleryItems.add(model);
          print("Successfully processed document with name: ${model.name}");
        } catch (e) {
          print("Error processing gallery document: $e");
          print("Problematic document: $doc");
        }
      }

      print("Successfully processed ${galleryItems.length} gallery items");
      return galleryItems;
    } catch (e) {
      print("Error in getGalleryImages: $e");
      return [];
    }
  }
}
