// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

MediaModel mediaModelFromJson(String str) =>
    MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel with ChangeNotifier {
  MediaModel({
    this.status,
    this.message,
    this.media,
  });

  bool? status;
  String? message;
  List<Media>? media;

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        status: json["status"],
        message: json["message"],
        media: List<Media>.from(json["quran"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "quran": List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Media {
  Media({
    this.title,
    this.category,
    this.description,
    this.file,
    this.bannerimage,
    this.image,
  });

  String? title;
  String? category;
  String? description;
  String? file;
  String? bannerimage;
  String? image;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        title: json["title"],
        category: json["category"],
        description: json["description"],
        file: json["file"],
        bannerimage: json["bannerimage"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "description": description,
        "file": file,
        "bannerimage": bannerimage,
        "image": image,
      };
}
