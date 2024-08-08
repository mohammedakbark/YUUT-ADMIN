class CartModel {
  String cartId;

  String productId;

  double quantity;

  CartModel(
      {required this.cartId, required this.productId, required this.quantity});

  Map<String, dynamic> toJson() =>
      {'cartId': cartId, 'productId': productId, 'quantity': quantity};

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"]);
}
