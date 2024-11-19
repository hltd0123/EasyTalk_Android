import 'dart:convert';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/TranscriptionResponse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/PronunciationExercises.dart';

class PronunciationExercisesService {
  static String domain = dotenv.env['domain']!;

  static Future<Map<String, dynamic>> getPronunciationExercises({
    int page = 1,
    int limit = 5,
  }) async {
    final prefs = await SharedPreferences.getInstance();


    final response = await http.get(
      Uri.parse('$domain/pronunciation-exercise/api/pronunciation-exercises?page=$page&limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'PronunciationExercisesList': List<PronunciationExercises>.from(data['data'].map((x) => PronunciationExercises.fromJson(x)),),
        'page': Page(
          totalPages: data['totalPages'],
          currentPage: data['currentPage'],
        ),
      };
    } else {
      throw Exception('Không thể lấy danh sách Pronunciation Exercises');
    }
  }

  static Future<PronunciationExercises?> getPronunciationExerciseOnId(String pronunciationExerciseId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.get(
      Uri.parse('$domain/pronunciation-exercise/api/$pronunciationExerciseId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PronunciationExercises.fromJson(data);
    } else {
      return null;
    }
  }

  /*static Future<double?> analyzePronunciationExercise(String exerciseId, int index, Blob audioBlob) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token không được null');
    }

    // Tạo FormData
    final formData = FormData();
    formData.append('audio', audioBlob, 'recording.wav');

    // Tạo request headers
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    // Gửi request POST
    final uri = Uri.parse('/pronunciation-exercise/analyze/$exerciseId/$index');
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(http.MultipartFile.fromBytes('audio', await audioBlob.arrayBuffer(), filename: 'recording.wav'));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);

        // Phân tích kết quả response và trả về accuracy
        final transcriptionResponse = TranscriptionResponse.fromJson(jsonData);
        return transcriptionResponse.accuracy;  // Trả về điểm (accuracy)
      } else {
        throw Exception('Không thể phân tích âm thanh');
      }
    } catch (e) {
      rethrow;
    }
  }*/

}
