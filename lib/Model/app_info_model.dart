class AppInfoModel {
  String email;
  String phoneNumber;
  String phoneNumber2;
  String facebookLink;
  String pinterestLink;
  String twitterLink;
  String instaLink;
  List<String> shop;
  String info;

  AppInfoModel({
    required this.email,
    required this.facebookLink,
    required this.pinterestLink,
    required this.twitterLink,
    required this.info,
    required this.instaLink,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.shop,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'phoneNumber': phoneNumber,
        'phoneNumber2': phoneNumber2,
        'facebookLink': facebookLink,
        'pinterestLink': pinterestLink,
        'twitterLink': twitterLink,
        'instaLink': instaLink,
        'shop': shop,
        'info': info,
      };

  factory AppInfoModel.fromJson(Map<String, dynamic> json) => AppInfoModel(
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        phoneNumber2: json['phoneNumber2'],
        facebookLink: json['facebookLink'],
        pinterestLink: json['pinterestLink'],
        twitterLink: json['twitterLink'],
        instaLink: json['instaLink'],
        shop: List<String>.from(json['shop']),
        info: json['info'],
      );
}
