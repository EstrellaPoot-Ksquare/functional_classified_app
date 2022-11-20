class AdModel {
  String? id;
  String? title;
  String? description;
  double? price;
  List<String>? images = [];
  String? authorName;
  String? userId;
  String? mobile;
  String? createdAt;
  AdModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.images,
    this.authorName,
    this.userId,
    this.mobile,
    this.createdAt,
  });

  AdModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    price = json['price'] != null ? json['price'].toDouble() : 0;
    images = json['images'] != null
        ? List<String>.from(json['images'].map((x) => x))
        : ['https://via.placeholder.com/300x400'];
    authorName = json['authorName'] ?? '';
    userId = json['userId'] ?? '';
    mobile = json['mobile'] ?? '';
    createdAt = json['createdAt'] ?? '';
  }
  Map<String, dynamic> toJson() => {
        '_id': id ?? '',
        'title': title,
        'description': description,
        'price': price,
        'images': images == null
            ? ['https://via.placeholder.com/300x400']
            : List<String>.from(images!.map((e) => e)),
        'authorName': authorName,
        'userId': userId,
        'mobile': mobile,
        'createdAt': createdAt,
      };
}
