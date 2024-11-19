import 'dart:convert';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/Pronunciation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PronunciationService {
  static String domain = dotenv.env['domain']!;

  static Future<Pronunciation?> getPronunciationDetails(String pronunciationId) async {
    final response = await http.get(
      Uri.parse('$domain/pronunciation/api/$pronunciationId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pronunciation.fromJson(data);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getPronunciationList() async {
    final response = await http.get(
      Uri.parse('$domain/admin/pronunciation/api/pronunciation-list'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('aaaaaaaaaaaaaaaaaaaa');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'pronunciations': List<Pronunciation>.from(data['pronunciations'].map((x) => Pronunciation.fromJson(x))),
        'page': Page(
          totalPages: data['totalPages'],
          currentPage: data['currentPage'],
        ),
      };
    } else {
      throw Exception('Không thể lấy danh sách Pronunciations');
    }
  }
}
