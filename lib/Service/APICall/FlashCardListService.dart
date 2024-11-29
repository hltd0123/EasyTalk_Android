import 'dart:convert';
import 'package:dacn/Model/FlashCardList.dart';
import 'package:dacn/Model/Page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FlashCardListService {
  static String domain = dotenv.env['domain']!;

  static Future<String?> addFlashCardList(FlashCardList flashCardList) async {
    // Nếu flashCardList đã có id thì không thêm nữa
    if (flashCardList.id != null) {
      return null;
    }

    final Map<String, dynamic> dataAdd = {
      'name': flashCardList.name,
      'description': flashCardList.description,
    };

    final response = await http.post(
      Uri.parse('$domain/flashcards/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(dataAdd),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);

      // Nếu API trả về thành công
      if (data['success'] == true) {
        return data['flashcardList']['insertedId'];  // Trả về insertedId nếu thành công
      }
    }

    return null;
  }

  static Future<bool> deleteFlashCardList(String flashcardListId) async {

    final response = await http.delete(
      Uri.parse('/flashcards/$flashcardListId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data['success'];
    } else {
      return false;
    }
  }

  static Future<bool> updateFlashCardList(FlashCardList flashCardList) async {

    if(flashCardList.id == null){
      return false;
    }

    final dataUpdate = {
      'name': flashCardList.name,
      'description': flashCardList.description,
    };

    final response = await http.put(
      Uri.parse('$domain/flashcards/flashcardlist/${flashCardList.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(dataUpdate), // Dùng toJson để gửi đầy đủ dữ liệu
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success']; // Trả về true nếu thành công
    } else {
      return false; // Trả về false nếu không thành công
    }
  }

  static Future<Map<String, dynamic>> getFlashCardListOnPage({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$domain/flashcards/api/flashcard-list?page=$page'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Lấy danh sách FlashCardList
      final List<dynamic> flashCardListData = data['flashcardLists'];
      List<FlashCardList> flashCardLists = flashCardListData
          .map((item) => FlashCardList.fromJson(item))
          .toList();

      // Trả về Map chứa danh sách, totalPages, và currentPage
      return {
        'flashCardLists': flashCardLists,
        'page': PageModel(
          totalPages: data['totalPages'],
          currentPage: data['currentPage'],
        ),
      };
    } else {
      throw Exception('Không thể lấy được dữ liệu các flashCardList và dữ liệu liên quan');
    }
  }

}
