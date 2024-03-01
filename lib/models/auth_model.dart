class UserModel {
  String email;
  String password;
  String id;

  UserModel({
    required this.email,
    required this.password,
    required this.id,
  });

  factory UserModel.fromMap({required Map data}) {
    return UserModel(
      email: data['email'],
      password: data['password'],
      id: data['id'],
    );
  }

  Map<String, dynamic> get toMap => {
        'email': email,
        'name': password,
        'id': id,
      };
}
