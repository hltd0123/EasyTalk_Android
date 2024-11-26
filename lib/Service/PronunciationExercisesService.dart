import 'dart:async';
import 'dart:convert';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/TranscriptionResponse.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/PronunciationExercises.dart';

class PronunciationExercisesService {
  static String domain = dotenv.env['domain']!;
  static final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

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

  static Function? stopRecordingCallback;
  static Future<String> recordAudio({Function? stopCallback}) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/recording.wav';

    // Lưu callback vào biến static
    stopRecordingCallback = stopCallback;

    // Khởi tạo recorder và bắt đầu ghi âm
    await _recorder.openRecorder();
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    return filePath;
  }

  // Hàm dừng ghi âm (gọi callback để dừng)
  static Future<void> stopRecording() async {
    // Dừng ghi âm
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();

    // Gọi callback nếu đã được set
    stopRecordingCallback?.call();
  }


  static Future<TranscriptionResponse> analyzePronunciationExercise(String exerciseId,int questionNumber, String filePathRecord) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    assert(token != null, 'Token ko dc null');

    // Tạo request headers
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    // Tạo URI cho request
    final uri = Uri.parse('$domain/pronunciation-exercise/analyze/$exerciseId/${questionNumber.toString()}');

    // Tạo MultipartRequest và thêm file vào request
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('audio', filePathRecord, filename: 'recording.wav'));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);

        // Phân tích kết quả response và trả về accuracy
        return TranscriptionResponse.fromJson(jsonData);
      } else {
        throw Exception('Không thể phân tích âm thanh');
      }
    } catch (e) {
      rethrow;
    }
  }

}
