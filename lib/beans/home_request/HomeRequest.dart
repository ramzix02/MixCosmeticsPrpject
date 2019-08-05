// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int status;
  String message;
  Data data;

  Post({
    this.status,
    this.message,
    this.data,
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Slider> slider;
  List<Product> products;
  List<Category> categories;
  Ads ads;

  Data({
    this.slider,
    this.products,
    this.categories,
    this.ads,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    slider: new List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
    products: new List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    categories: new List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    ads: Ads.fromJson(json["ads"]),
  );

  Map<String, dynamic> toJson() => {
    "slider": new List<dynamic>.from(slider.map((x) => x.toJson())),
    "products": new List<dynamic>.from(products.map((x) => x.toJson())),
    "categories": new List<dynamic>.from(categories.map((x) => x.toJson())),
    "ads": ads.toJson(),
  };
}

class Ads {
  String title;
  String image;

  Ads({
    this.title,
    this.image,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => new Ads(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}

class Category {
  int id;
  String name;
  String image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class Product {
  int id;
  String name;
  String category;
  String image;
  int price;
  Currency currency;
  int favourite;

  Product({
    this.id,
    this.name,
    this.category,
    this.image,
    this.price,
    this.currency,
    this.favourite,
  });

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    image: json["image"],
    price: json["price"],
    currency: currencyValues.map[json["currency"]],
    favourite: json["favourite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "image": image,
    "price": price,
    "currency": currencyValues.reverse[currency],
    "favourite": favourite,
  };
}

enum Currency { LE }

final currencyValues = new EnumValues({
  "LE": Currency.LE
});

class Slider {
  String title;
  String details;
  String link;
  String image;

  Slider({
    this.title,
    this.details,
    this.link,
    this.image,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => new Slider(
    title: json["title"],
    details: json["details"],
    link: json["link"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "details": details,
    "link": link,
    "image": image,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
