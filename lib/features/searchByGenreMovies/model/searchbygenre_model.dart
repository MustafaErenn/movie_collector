// To parse this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
  GenreModel({
    this.genres,
  });

  List<Genre> genres;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
