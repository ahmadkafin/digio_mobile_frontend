class ProductsResponse {
  ProductsResponse({
    required this.uid,
    required this.name,
    required this.image,
    required this.video,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  String? uid, name, image, video, description;
  DateTime? createdAt, updatedAt;

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        uid: json['uid'],
        name: json['name'],
        image: json['image'],
        video: json['video'],
        description: json['description'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'image': image,
        'video': video,
        'description': description,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
