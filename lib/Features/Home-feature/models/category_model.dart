class CategoryModel {
  String? image;
  String? categoryName;
  String? id;
  bool? subCat;
  bool? isSelected;

  CategoryModel({
    this.image,
    this.categoryName,
    this.subCat,
    this.isSelected = false,
  });

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    categoryName = json!['categoryName'] ?? json['name'];
    image = json['image'];
    id = json['id'] ?? '';
    subCat = json['subCat'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': categoryName,
      'image': image,
      'id': id,
      'subCat': subCat,
    };
  }

}
