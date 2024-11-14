import 'package:dacn/Model/GrammarExercise.dart';
import 'package:dacn/Model/Page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GrammarExerciseService {
  static String domain = dotenv.env['domain']!;

  static Future<GrammarExercise?> getGrammarExercise(String grammarExerciseId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    final response = await http.get(
      Uri.parse('$domain/grammar-exercise/api/$grammarExerciseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GrammarExercise.fromJson(data);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getGrammarExercisesOnPage(int page, int limit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    final response = await http.get(
      Uri.parse('$domain/grammar-exercise/api/grammar-exercises?page=$page&limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final exercises = (data['data'] as List)
          .map((json) => GrammarExercise.fromJson(json))
          .toList();
      final page = Page.fromJson(data);

      return {
        'grammarExercises': exercises,
        'page': page,
      };
    } else {
      throw Exception('Tải dữ liệu Grammar Exercises và các dự liệu liên quan thất bại');
    }
  }
}
