class UserModel {
  String ?uid;
  String name;
  String email;
  String phone;
  String password;

  UserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.password,
       this.uid});

  Map<String, dynamic> toJson(id) =>
      {'uid': id, 'name': name, 'email': email, 'phone': phone};

  factory UserModel.fromjson(Map<String, dynamic> json) => UserModel(
    password: '',
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      uid: json['uid']);
}
