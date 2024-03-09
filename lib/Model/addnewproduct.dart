class AddNewProduct {
  String productId;
 List< String>image;
  String name;
  String description;
  double prize;

  AddNewProduct(
      {required this.description,
      required this.image,
      required this.name,
      required this.prize,
      required this.productId});

  Map<String, dynamic> toJon() => {
        "productId": productId,
        "image": image,
        "name": name,
        "description": description,
        "prize": prize
      };
  factory AddNewProduct.fromJson(Map<String, dynamic> json) {
    return AddNewProduct(
        description: json["description"],
        image: json["image"],
        name: json["name"],
        prize: json["prize"],
        productId: json["productId"]);
  }
}
