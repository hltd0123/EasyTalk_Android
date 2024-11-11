class Users {
  String id; // ID lưu dưới dạng String để tương thích MongoDB
  String username;
  String password;
  String email;
  String role;
  bool active;

  Users({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    this.active = true,
  });

  // Phương thức chuyển đổi object thành JSON theo định dạng MongoDB
  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id}, // Dùng định dạng JSON MongoDB cho ObjectId
      'username': username,
      'password': password,
      'email': email,
      'role': role,
      'active': active,
    };
  }

  // Phương thức khởi tạo object từ JSON MongoDB
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id']['\$oid'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      active: json['active'] ?? true,
    );
  }

  String getTableName(){
    return 'users';
  }
}
