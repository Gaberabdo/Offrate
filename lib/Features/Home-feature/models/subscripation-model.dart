import 'package:cloud_firestore/cloud_firestore.dart';

class SubscripationModel {
  String? name;
  String? id;
  dynamic? price;
  dynamic? discount;



  SubscripationModel({
    this.name,
    this.price,
    this.discount,
    this.id


  });

  SubscripationModel.fromJson(Map<String, dynamic>? json) {
    price = json!['price'] ?? '';
    name = json['name'] ?? '';
    id = json['id'] ?? '';
    discount = json['discount'] ?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'discount': discount,
      'id': id

    };
  }
}
