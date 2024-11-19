import 'dart:convert';

import 'package:dacn/Model/Stage.dart';
import 'package:dacn/Model/UserProgress.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StageService {
  static String domain = dotenv.env['domain']!;

  static Future<Map<String, dynamic>?> getStageOnId(String stageId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.get(
      Uri.parse('$domain/stage/api/stage/detail/$stageId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      var stage = Stage.fromJson(data['stage']);
      var userProgress = UserProgress.fromJson(data['userProgress']);

      return {
        'stage': stage,
        'userProgress': userProgress,
      };
    } else {
      return null;
    }
  }

  static Future<bool> setCompleteState(String stageId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.post(
      Uri.parse('$domain/stage/api/stage/complete/$stageId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
