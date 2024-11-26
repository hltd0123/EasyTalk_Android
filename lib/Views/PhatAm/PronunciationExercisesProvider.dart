import 'package:dacn/Model/PronunciationExercisesQuestion.dart';
import 'package:dacn/Service/PronunciationExercisesService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PronunciationExercisesProvider with ChangeNotifier {
  String exerciseId;
  final List<PronunciationExercisesQuestion> questions;
  int _currentIndex = 0;
  String? _selectedOption;
  bool? _answerChecked;
  bool _recording = false;
  bool sending = false;
  String filePathRecord = '';
  String answer = '';
  double point = 0;

  PronunciationExercisesProvider({required this.questions, required this.exerciseId});

  PronunciationExercisesQuestion get currentQuestion => questions[_currentIndex];
  int get currentIndex => _currentIndex;
  bool get hasNext => _currentIndex < questions.length - 1;
  String? get selectedOption => _selectedOption;
  bool? get answerChecked => _answerChecked;
  bool get recording => _recording;

  void nextQuestion() {
    if (hasNext) {
      answer = '';
      filePathRecord = '';
      sending = false;
      _currentIndex++;
      _resetState();
      notifyListeners();
    }
  }

  void skipQuestion() => nextQuestion();

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  void checkAnswer() {
    if (_selectedOption != null) {
      _answerChecked = _selectedOption == currentQuestion.correctAnswer;
      notifyListeners();
    }
  }

  Future<void> startRecording() async {
    if (_recording) return; // Tránh gọi lại nếu đã đang ghi âm
    _recording = true;
    notifyListeners(); // Thông báo trạng thái bắt đầu ghi âm

    // Gọi service để bắt đầu ghi âm và lưu callback cho việc dừng ghi âm
    filePathRecord = await PronunciationExercisesService.recordAudio(
      stopCallback: () {
        stopRecordingCallbackFunction(); // Dừng ghi âm khi callback được gọi
      },
    );
  }

  Future<void> stopRecording() async {
    if (!_recording) return; // Tránh gọi khi không ở trạng thái ghi âm
    _recording = false;

    // Gọi stopRecording từ service để dừng ghi âm
    await PronunciationExercisesService.stopRecording();

    sending = true;
    notifyListeners();
    // Phân tích kết quả ghi âm sau khi dừng
    var ans = await PronunciationExercisesService.analyzePronunciationExercise(
      exerciseId,
      _currentIndex,
      filePathRecord,
    );

    // Cập nhật điểm và kết quả chi tiết
    point = ans.accuracy;
    answer = ans.detailedResult
        .map((ansPer) => ansPer.correct ? 'T' : 'F')
        .join();
    sending = false;
    notifyListeners(); // Thông báo trạng thái dừng ghi âm
  }

  void stopRecordingCallbackFunction() {
    stopRecording();
    print('Recording stopped and analyzed');
  }

  void _resetState() {
    _selectedOption = null;
    _answerChecked = null;
    _recording = false;
  }
}
