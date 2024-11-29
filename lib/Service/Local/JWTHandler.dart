import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JWTHandler {
  final String secret;

  JWTHandler(this.secret);

  // Phương thức tạo token với user và password
  String generateToken(String user, String password) {
    final jwt = JWT({
      'user': user,
      'password': password,
    });

    // Ký JWT với `secret`
    return jwt.sign(SecretKey(secret));
  }

  // Phương thức xác minh token
  Map<String, dynamic>? verifyToken(String token) {
    try {
      // Xác minh và giải mã token
      final jwt = JWT.verify(token, SecretKey(secret));
      return jwt.payload; // Trả về payload nếu xác minh thành công
    } catch (e) {
      return null; // Trả về null nếu xác minh thất bại
    }
  }
}
