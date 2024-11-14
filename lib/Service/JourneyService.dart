import 'dart:convert';
import 'package:dacn/Model/UserProgress.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dacn/Model/Journey.dart';
import 'package:dacn/Model/Leaderboard.dart';

class JourneyService {
  static Future<Map<String, dynamic>> getJourneyList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    final response = await http.get(
      Uri.parse('/journey/api'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'journeys': List<Journey>.from(data['journeys'].map((x) => Journey.fromJson(x))),
        'userProgress': UserProgress.fromJson(data['userProgress']),
        'totalStages': data['totalStages'],
        'totalGates': data['totalGates'],
        'completedGates': data['completedGates'],
        'completedStages': data['completedStages'],
        'progressPercentage': data['progressPercentage'],
        'leaderboard': List<Leaderboard>.from(data['leaderboard'].map((x) => Leaderboard.fromJson(x))),
      };
    } else {
      throw Exception('Không thể lấy danh sách journey và các dữ liệu liên quan');
    }
  }

  static Future<Map<String, dynamic>> getJourneyOnJourneyId(String journeyId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    final response = await http.get(
      Uri.parse('/journey/api/$journeyId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'journey': Journey.fromJson(data['journey']),
        'userProgress': UserProgress.fromJson(data['userProgress']),
        'completedGates': data['completedGates'],
        'completedStages': data['completedStages'],
        'leaderboard': List<Leaderboard>.from(data['leaderboard'].map((x) => Leaderboard.fromJson(x))),
      };
    } else {
      throw Exception('Không thể lấy dữ liệu Journey và các dữ liệu liên quan');
    }
  }
}
