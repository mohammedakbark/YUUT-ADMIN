class AddressModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String country;
  String city;
  String area;
  String postCode;
  String streetAddress;

  AddressModel(
      {required this.area,
      required this.city,
      required this.country,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.postCode,
      required this.streetAddress});

Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'country': country,
        'city': city,
        'area': area,
        'postCode': postCode,
        'streetAddress': streetAddress,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        country: json['country'],
        city: json['city'],
        area: json['area'],
        postCode: json['postCode'],
        streetAddress: json['streetAddress'],
      );

}
