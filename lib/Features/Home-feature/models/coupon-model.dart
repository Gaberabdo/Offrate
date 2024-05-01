import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  String? name;
  String? id;
  dynamic? price;




  CouponModel({
    this.name,
    this.price,

    this.id


  });

  CouponModel.fromJson(Map<String, dynamic>? json) {
    price = json!['price'] ?? '';
    name = json['name'] ?? '';
    id = json['id'] ?? '';


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,

      'id': id

    };
  }
}
