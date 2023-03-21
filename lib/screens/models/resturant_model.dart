import 'package:flutter/cupertino.dart';

class Resturant {
  Resturant({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? uid,
    String? imageUrl,
    int? rating,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _password = password;
    _phoneNumber = phoneNumber;
    _uid = uid;
    _imageUrl = imageUrl;
    _rating = rating;
  }

  Resturant.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _uid = json['uid'];
    _imageUrl = json['imageUrl'];
    _rating = json['rating'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _imageUrl;
  int? _rating;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;
  int? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['uid'] = _uid;
    map['imageUrl'] = _imageUrl;
    map['rating'] = _rating;

    return map;
  }
}
