class User {
  String id;
  String username;
  String email;
  String password;
  String role;
  bool active;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      active: json['active'],
    );
  }
}
