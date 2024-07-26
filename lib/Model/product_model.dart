class ProductModel {
  String? productId;
  List<dynamic> image;
  String name;
  String productDetails;
  String productDimensions;
  String deliveryAndRetturn;
  double prize;
  int quantity;

  ProductModel(
      {required this.deliveryAndRetturn,
      required this.productDetails,
      required this.productDimensions,
      required this.quantity,
      required this.image,
      required this.name,
      required this.prize,
      this.productId});

  Map<String, dynamic> toJon(id) => {
        "quantity": quantity,
        "productDimensions": productDimensions,
        "deliveryAndRetturn": deliveryAndRetturn,
        "productId": id,
        "image": image,
        "name": name,
        "productDetails": productDetails,
        "prize": prize
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
        productId: json["productId"]);
  }
}
