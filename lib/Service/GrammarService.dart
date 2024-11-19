import 'dart:convert';
import 'package:dacn/Model/Grammar.dart';
import 'package:dacn/Model/Page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GrammarService {
  static String domain = dotenv.env['domain']!;

  static Future<Map<String, dynamic>?> getGrammarListOnPageAndLimit({int page = 1, int limit = 2}) async {
    final response = await http.get(
      Uri.parse('$domain/grammar-exercise/api/grammars?page=$page&limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Trả về Map với 'grammars' và 'page'
      return {
        'grammars': (data['grammars'] as List)
            .map((grammarJson) => Grammar.fromJson(grammarJson))
            .toList(),
        'page': Page.fromJson({
          'currentPage': data['currentPage'],
          'totalPages': data['totalPages'],
        }),
      };
    } else {
      return null;
    }
  }

  static Future<Grammar?> getGrammarOnId(String grammarId) async {
    final response = await http.get(
      Uri.parse('$domain/grammar-exercise/api/$grammarId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Grammar.fromJson(data);
    } else {
      return null;
    }
  }
}
