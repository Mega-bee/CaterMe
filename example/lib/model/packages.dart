import 'package:CaterMe/model/details.dart';

class Package {
  int id;
  bool perperson = false;

  String image = "";
  double tax = 0.0;
  String title = "";
  String description = "";
  double price = 0;
  bool isfavorite = false;
  List<Details> itemDetails = [];
  int min = 1, max = 1000, increment = 5;

  bool isShisha = false;

  Package(this.id, this.image, this.title, this.description, this.price,
      this.isfavorite, this.itemDetails);

  Package.fromJson(Map<String, dynamic> json, String a) {
    tax = json['tax'] == null ? 0 : double.parse(json['tax'].toString());
    id = json['id'] ?? 0;

    if (a == "ar") {
      image = json['imageAR'] ?? "not found";
      title = json['titleAR'] ?? "not found";
      description = json['descriptionAR'] ?? "غير معروف";
    } else {
      image = json['image'] ?? "not found";
      title = json['title'] ?? "not found";
      description = json['description'] ?? "not found";
    }
    price = double.parse(json['price'].toString()) ?? 0.0;
    isfavorite = json['isFavorite'] ?? false;
    min = json["min"] ?? 1;
    max = json["max"] ?? 1000;
    perperson = json["isSoldPerPackage"] ?? false;
    increment = json["increment"] ?? 1;
    isShisha = json["isShisha"] ?? false;
    if (json['itemDetails'] != null) {
      itemDetails = [];
      json['itemDetails'].forEach((v) {
        itemDetails.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = tax;
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    if (itemDetails != null) {
      data['itemDetails'] = itemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
