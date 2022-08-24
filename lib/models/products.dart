import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, Products> productsFromMap(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Products>(k, Products.fromMap(v)));

String productsToMap(Map<String, Products> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())));

class Products {
  Products({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
  });

  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
