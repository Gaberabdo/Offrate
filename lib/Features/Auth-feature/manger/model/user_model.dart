import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? token;
  String? platform;
  bool? blocked;
  Timestamp? blockTimestamp;

  UserModel({
    this.name,
    this.email,
    this.token,
    this.phone,
    this.uId,
    this.image,
    this.blocked,
    this.blockTimestamp,
    this.platform,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    uId = json['uId'] ?? '';
    token = json['token'] ?? '';
    image = json['image'] ?? '';
    platform = json['platform'] ?? 'Android';
    blocked = json['blocked'] ?? false;
    blockTimestamp = json['blockTimestamp'] != null
        ? json['blockTimestamp']
        : null; // Convert to Timestamp if not null
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'platform': platform,
      'token': token,
      'blocked': blocked,
      'blockTimestamp': blockTimestamp,
    };
  }
}
