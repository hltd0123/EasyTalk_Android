import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AiChatService{
  static String domain = dotenv.env['domain']!;

  static Future<String> sendingChatAndGetResoine(String mess) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, 'Token ko dc null');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final uri = Uri.parse('$domain/api/chat');

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode({'message' : mess}),
    );

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      return data['response'];
    }
    return '';
  }
}