class ProductModel {
  final int? view;
  final String? time;
  final List<String>? images;
  final String? cat;
  final double? lat;
  final double? lan;
  final String? reasonOfOffer;
  final String? description;
  final String? location;
  final String? details;
  final dynamic price;
  final dynamic numberOfDay;
  final String? uId;
  final String? video;
  String? id;
  bool? fave;
  dynamic? isOffer;

  ProductModel({
    this.view,
    this.time,
    this.images,
    this.id,
    this.cat,
    this.lat,
    this.lan,
    this.reasonOfOffer,
    this.description,
    this.location,
    this.details,
    this.price,
    this.video,
    this.numberOfDay,
    this.uId,
    this.fave,
    this.isOffer,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      view: json['view'],
      time: json['time'],
      images: List<String>.from(json['images']),
      cat: json['cat'],
      lat: json['lat'],
      video: json['video'] ?? '',
      lan: json['lan'],
      reasonOfOffer: json['reasonOfOffer'],
      description: json['description'],
      details: json['details'],
      isOffer: json['isOffer'] ?? false,
      price: json['price'],
      location: json['location'],
      uId: json['uId'],
      fave: json['fave'],
      numberOfDay: json['numberOfDay'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'view': view,
      'time': time,
      'images': images,
      'cat': cat,
      'lat': lat,
      'lan': lan,
      'reasonOfOffer': reasonOfOffer,
      'description': description,
      'details': details,
      'price': price,
      'location': location,
      'uId': uId,
      'video': video,
      'fave': fave,
      'isOffer': isOffer,
      'numberOfDay': numberOfDay,
    };
  }

  static List<ProductModel> dummyData = List.generate(
    10,
    (index) {
      return ProductModel(
        view: 1000 + index,
        time: 'Thu Mar ${index + 1} 2024 15:30:00 GMT+0530 (IST)',
        images: [
          'https://via.placeholder.com/700',
          'https://via.placeholder.com/700',
          'https://via.placeholder.com/700',
          'https://via.placeholder.com/700',
          'https://via.placeholder.com/700',
        ],
        cat: 'category',
        lat: 20.1,
        lan: 19.5,
        location: 'location',
        reasonOfOffer: 'reason',
        description: 'description',
        details: 'details',
        price: '\$100',
        uId: 'KnETMu0imdf5azkIlUM8KOqzfcf2',
        fave: false,
      );
    },
  );
}
