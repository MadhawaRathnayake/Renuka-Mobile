import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  ObjectId id;
  String destinationName;
  String userId;
  String destImage;
  String description;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MongoDbModel({
    required this.id,
    required this.destinationName,
    required this.userId,
    required this.destImage,
    required this.description,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        destinationName: json["destinationName"],
        userId: json["userId"],
        destImage: json["destImage"],
        description: json["description"],
        slug: json["slug"],
        createdAt: json["createdAt"] is DateTime
            ? json["createdAt"]
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] is DateTime
            ? json["updatedAt"]
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "destinationName": destinationName,
        "userId": userId,
        "destImage": destImage,
        "description": description,
        "slug": slug,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class GalleryModel {
  ObjectId id;
  String name;
  String imageURL;
  String city;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GalleryModel({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    try {
      return GalleryModel(
        id: json["_id"],
        name: json["name"],
        imageURL: json["imageURL"],
        city: json["city"],
        createdAt: json["createdAt"] is DateTime
            ? json["createdAt"]
            : DateTime.parse(json["createdAt"].toString()),
        updatedAt: json["updatedAt"] is DateTime
            ? json["updatedAt"]
            : DateTime.parse(json["updatedAt"].toString()),
        v: json["__v"],
      );
    } catch (e) {
      print("Error creating GalleryModel from JSON: $e");
      print("Problematic JSON: $json");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "imageURL": imageURL,
        "city": city,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
