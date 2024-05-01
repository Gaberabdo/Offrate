class CommentModel {
  String? commentId;
  String? text;
  String? dataTime;
  String? name;
  String? phone;
  String? image;
  List<String>? commentLikes = [];
  dynamic? price;
  String? uid;

  CommentModel({
    this.text,
    this.dataTime,
    this.phone,
    this.commentId,
    this.name,
    this.commentLikes,
    this.price,
    this.uid,
    this.image,
  });

  CommentModel.fromJson(Map<dynamic, dynamic> json) {
    text = json['text'];
    commentId = json['commentId'];
    dataTime = json['dataTime'];
    phone = json['phone'];
    commentLikes = json['commentLikes'];
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dataTime': dataTime,
      'commentId': commentId,
      'phone': phone,
      'commentLikes': commentLikes,
      'price': price,
      'name': name,
      'uid': uid,
      'image': image
    };
  }
}
