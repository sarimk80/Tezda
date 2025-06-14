class LikeProductModel {
  final String productId;
  final bool isLike;

  LikeProductModel({required this.productId, required this.isLike});

  Map<String, dynamic> toMap() => {'productId': productId, 'isLike': isLike};

  factory LikeProductModel.fromMap(Map<String, dynamic> map) =>
      LikeProductModel(productId: map['productId'], isLike: map['isLike']);
}
