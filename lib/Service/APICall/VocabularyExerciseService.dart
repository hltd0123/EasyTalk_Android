import 'dart:convert';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/Vocabulary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VocabularyExerciseService {
  static String domain = dotenv.env['domain']!;

  static Future<Map<String, dynamic>?> getVocabularyExercisesOnPageAndLimit(
      {int page = 1, int limit = 2}) async {
    final response = await http.get(
      Uri.parse('$domain/vocabulary-exercise/api/vocabulary-exercises?page=$page&limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'vocabularies': (data['data'] as List)
            .map((vocabJson) => Vocabulary.fromJson(vocabJson))
            .toList(),
        'page': PageModel.fromJson(
          {
            'currentPage': data['currentPage'],
            'totalPages': data['totalPages'],
          }
        )
      };
    } else {
      return null;
    }
  }

  static Future<Vocabulary?> getVocabularyOnId(String vocabularyExerciseId) async {
    final response = await http.get(
      Uri.parse('$domain/vocabulary-exercise/api/$vocabularyExerciseId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Vocabulary.fromJson(data);
    } else {
      return null;
    }
  }

}
