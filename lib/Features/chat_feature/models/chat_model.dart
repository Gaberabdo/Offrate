class MessageModel {
  MessageModel({
    this.senderId,
    this.receiverId,
    this.message,
    this.time,
    this.image,
  });

  late final String? senderId;
  late final String? receiverId;
  late final String? message;
  late final String? time;
  late final String? image;

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'] ?? '';
    receiverId = json['receiverId'] ?? '';
    message = json['message'] ?? '';
    time = json['dateTime'] ?? '';
    image = json['image'] ?? '';
  }
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': time,
      'image': image,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': time,
      'image': image,
    };
  }
}
