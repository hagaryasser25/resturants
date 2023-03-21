import 'package:flutter/cupertino.dart';

class Meal {
  Meal({
    String? id,
    String? content,
    String? name,
    String? date,
    int? price,
    String? type,
    String? imageUrl,
  }) {
    _id = id;
    _content = content;
    _name = name;
    _date = date;
    _price = price;
    _type = type;
    _imageUrl = imageUrl;
  }

  Meal.fromJson(dynamic json) {
    _id = json['id'];
    _content = json['content'];
    _name = json['name'];
    _date = json['date'];
    _price = json['price'];
    _type = json['type'];
    _imageUrl = json['imageUrl'];
  }

  String? _id;
  String? _content;
  String? _name;
  String? _date;
  int? _price;
  String? _type;
  String? _imageUrl;

  String? get id => _id;
  String? get content => _content;
  String? get name => _name;
  String? get date => _date;
  int? get price => _price;
  String? get type => _type;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['content'] = _content;
    map['name'] = _name;
    map['date'] = _date;
    map['price'] = _price;
    map['type'] = _type;
    map['imageUrl'] = _imageUrl;
    return map;
  }
}
