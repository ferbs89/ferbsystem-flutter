class User {
  final int id;
  final String name;
  final String email;
  final String token;

  User({this.id, this.name, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}