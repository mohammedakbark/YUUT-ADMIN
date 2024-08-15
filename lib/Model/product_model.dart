class ProductModel {
  String? productId;
  List<dynamic> image;
  String name;
  String productDetails;
  String productDimensions;
  String deliveryAndRetturn;
  double prize;
  int quantity;
  List<String> sizes;

  ProductModel(
      {required this.deliveryAndRetturn,
      required this.productDetails,
      required this.productDimensions,
      required this.quantity,
      required this.image,
      required this.name,
      required this.prize,
      required this.sizes,
      this.productId});

  Map<String, dynamic> toJon(id) => {
        "quantity": quantity,
        "productDimensions": productDimensions,
        "deliveryAndRetturn": deliveryAndRetturn,
        "productId": id,
        "image": image,
        "name": name,
        "productDetails": productDetails,
        "prize": prize,
        "sizes": sizes.map((e) => e).toList(),
      };
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        quantity: json["quantity"],
        deliveryAndRetturn: json["deliveryAndRetturn"],
        productDimensions: json["productDimensions"],
        productDetails: json["productDetails"],
        image: json["image"],
        name: json["name"],
        prize: json["prize"],
        sizes: List<String>.from(json["sizes"]),
        productId: json["productId"]);
  }
}
