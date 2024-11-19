import 'dart:convert';
import 'package:dacn/Model/Achievements.dart';
import 'package:dacn/Model/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static String domain = dotenv.env['domain']!;

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$domain/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      return null;
    }
  }

  static Future<bool> register(String username, String email, String password, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$domain/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    return response.statusCode == 201;
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.get(
      Uri.parse('$domain/profile/data'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Parse user, achievements từ response JSON
      var user = User.fromJson(data['user']);
      var achievements = Achievements.fromJson(data['achievements']);

      return {
        'user': user,
        'achievements': achievements,
      };
    } else {
      return null;
    }
  }

  static Future<bool> updateProfile(String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.post(
      Uri.parse('$domain/profile/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }

  static Future<bool> resetPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('$domain/reset-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$domain/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Hàm verify code
  static Future<bool> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('$domain/verify-code'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Hàm change password
  static Future<bool> changePassword(String currentPassword, String newPassword, String confirmNewPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.post(
      Uri.parse('$domain/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
