import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Reminder.dart';

class ReminderService {
  static String domain = dotenv.env['domain']!;

  static Future<List<Reminder>?> getReminderList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.get(
      Uri.parse('$domain/api/reminders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Reminder>.from(
        data['reminders'].map((reminder) => Reminder.fromJson(reminder)),
      );
    } else {
      return null;
    }
  }

  static Future<Reminder?> getReminder(String reminderId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.get(
      Uri.parse('$domain/reminder/api/reminder/$reminderId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Reminder.fromJson(data);
    } else {
      return null;
    }
  }

  static Future<bool> updateReminder(Reminder updatedReminder) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final updateData = {
      'email': updatedReminder.email,
      'reminderTime': updatedReminder.reminderTime,
      'frequency': updatedReminder.frequency,
      'additionalInfo': updatedReminder.additionalInfo,
    };

    final response = await http.put(
      Uri.parse('/reminder/api/reminder/${updatedReminder.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updateData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteReminder(String reminderId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, "Token không được null");

    final response = await http.delete(
      Uri.parse('/reminder/api/reminder/$reminderId'),
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
