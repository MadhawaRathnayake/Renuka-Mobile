import 'package:mongo_dart/mongo_dart.dart';
import 'package:renuka_travels/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection("destinations");
  }

  static Future<List<String>> getDestinationNames() async {
    final arrData = await userCollection
        .find()
        .map((doc) => doc['destinationName'] as String)
        .toList();
    return List<String>.from(arrData);
  }

  static Future<List<Map<String, String>>> getDestinationCard() async {
    final cardData = await userCollection.find().map((doc) {
      return {
        'destinationName': doc['destinationName'] as String,
        'destImage': doc['destImage'] as String,
        'description': doc['description'] as String,
      };
    }).toList();
    return List<Map<String, String>>.from(cardData);
  }
}
