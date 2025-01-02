// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

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
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
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
