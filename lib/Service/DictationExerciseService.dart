import 'dart:convert';
import 'package:dacn/Model/DictationExercise.dart';
import 'package:dacn/Model/Page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DictationExerciseService {
  static String domain = dotenv.env['domain']!;

  static Future<Map<String, dynamic>?> getDictationExercises(
      {int page = 1, int limit = 6}) async {
    final response = await http.get(
      Uri.parse('$domain/dictation-exercise/api/dictation-exercises?page=$page&limit=$limit'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'dictationExercises': (data['dictationExercises'] as List)
            .map((dictationJson) => DictationExercise.fromJson(dictationJson))
            .toList(),
        'page': Page.fromJson({
          'currentPage': data['currentPage'],
          'totalPages': data['totalPages'],
        })
      };
    } else {
      return null;
    }
  }

  static Future<DictationExercise?> getDictationExerciseOnId(String dictationExerciseId) async {
    final response = await http.get(
      Uri.parse('$domain/dictation-exercise/api/$dictationExerciseId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == true) {
        return DictationExercise.fromJson(data['data']);
      }
    }
    // Trả về null nếu không tìm thấy dữ liệu hoặc có lỗi
    return null;
  }
}
