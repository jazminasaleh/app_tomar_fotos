import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, Products> productsFromMap(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Products>(k, Products.fromMap(v)));

String productsToMap(Map<String, Products> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())));

class Products {
  Products(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      this.id});

  bool available;
  String name;
  String? picture;
  double price;
  String? id;
  factory Products.fromJson(String str) => Products.fromJson(json.decode(str));
  String toJson() => json.encode(toMap());
  
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

  Products copy() => Products(
      available: this.available,
      name: this.name,
      price: this.price,
      picture: this.picture,
      id: this.id);
}
