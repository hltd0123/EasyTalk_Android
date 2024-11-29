import 'dart:convert';
import 'package:dacn/Model/FlashCard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FlashCardService {
  static String domain = dotenv.env['domain']!;

  static Future<String?> addFlashCard(FlashCard flashCard, String flashCardListId) async {
    // Lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    if (flashCard.id != null){
      return null;
    }

    final Map<String, dynamic> dataAdd = {
      'word': flashCard.word,
      'meaning': flashCard.meaning,
      'pos': flashCard.pos,
      'pronunciation': flashCard.pronunciation,
      'exampleSentence': flashCard.exampleSentence,
      'image': flashCard.image,
    };

    final response = await http.put(
      Uri.parse('$domain/flashcards/flashcardlist/flashcardListId/$flashCardListId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Thêm token vào header
      },
      body: json.encode(dataAdd),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Nếu API trả về thành công
      if (data['success']) {
        return data['flashcard']['insertedId'];  // Trả về insertedId nếu thành công
      }
    }
    return null;
  }


  static Future<bool> deleteFlashCardOnId(String flashcardId) async {
    // Lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    final response = await http.delete(
      Uri.parse('$domain/flashcards/delete-flashcard/$flashcardId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success']; // Trả về true nếu xóa thành công
    } else {
      return false; // Trả về false nếu không thành công
    }
  }

  static Future<bool> updateFlashCard(FlashCard flashCard) async {
    // Lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null);

    if (flashCard.id == null){
      return false;
    }

    final Map<String, dynamic> dataUpdate = {
      'word': flashCard.word,
      'meaning': flashCard.meaning,
      'pos': flashCard.pos,
      'pronunciation': flashCard.pronunciation,
      'exampleSentence': flashCard.exampleSentence,
      'image': flashCard.image,
    };

    // Thực hiện PUT request để cập nhật flashcard
    final response = await http.put(
      Uri.parse('$domain/flashcards/update-flashcard/${flashCard.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Thêm token vào header
      },
      body: json.encode(dataUpdate)
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Nếu API trả về thành công
      return data['success'] == true;
    } else {
      return false; // Trả về false nếu không thành công
    }
  }

}
