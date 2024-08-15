
class CartModel {
  String cartId;
  String productId;
  double quantity;
  String size;

  CartModel(
      {
        required this.size,
        required this.cartId, required this.productId, required this.quantity});

  Map<String, dynamic> toJson() =>
      {'cartId': cartId, 'productId': productId, 'quantity': quantity,'size':size};

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    size:json['size'],
      cartId: json["cartId"],
      productId: json["productId"],
      quantity: json["quantity"]);
}
