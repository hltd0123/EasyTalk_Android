import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PracticeExercisePage extends StatefulWidget {
  final int exerciseIndex;  // Nhận thông tin bài tập từ StudyPagePhatAm

  const PracticeExercisePage({super.key, required this.exerciseIndex});

  @override
  _PracticeExercisePageState createState() => _PracticeExercisePageState();
}

class _PracticeExercisePageState extends State<PracticeExercisePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  bool _isMicTapped = false;
  bool _isSpeakerTapped = false; // Biến lưu trạng thái loa
  int _currentQuestionIndex = 0;

  int _correctAnswers = 0;  // Số câu đúng
  int _incorrectAnswers = 0;  // Số câu sai

  // Danh sách các bài tập phát âm với 5 câu hỏi mỗi bài
  final List<List<Map<String, String>>> exercises = [
    [ // Bài tập phát âm 1
      {'question': 'Say "sip"', 'correctAnswer': 'sip'},
      {'question': 'Say "she"', 'correctAnswer': 'she'},
      {'question': 'Say "think"', 'correctAnswer': 'think'},
      {'question': 'Say "juice"', 'correctAnswer': 'juice'},
      {'question': 'Say "bat"', 'correctAnswer': 'bat'},
    ],
    [ // Bài tập phát âm 2
      {'question': 'Say "juice"', 'correctAnswer': 'juice'},
      {'question': 'Say "bat"', 'correctAnswer': 'bat'},
      {'question': 'Say "fish"', 'correctAnswer': 'fish'},
      {'question': 'Say "dog"', 'correctAnswer': 'dog'},
      {'question': 'Say "elephant"', 'correctAnswer': 'elephant'},
    ],
    [ // Bài tập phát âm 3
      {'question': 'Say "I like ice cream"', 'correctAnswer': 'I like ice cream'},
      {'question': 'Say "She is going to school"', 'correctAnswer': 'She is going to school'},
      {'question': 'Say "This is a book"', 'correctAnswer': 'This is a book'},
      {'question': 'Say "I am happy"', 'correctAnswer': 'I am happy'},
      {'question': 'Say "Let\'s go to the park"', 'correctAnswer': 'Let\'s go to the park'},
    ],
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _toggleListening() async {
    if (_isListening) {
      setState(() {
        _isListening = false;
        _isMicTapped = false;
      });
      _speech.stop();
      _checkAnswer();  // Kiểm tra câu trả lời khi ngừng ghi âm
    } else {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _isMicTapped = true;
        });
        _speech.listen(onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
          });
        });
      } else {
        setState(() {
          _spokenText = 'Speech recognition not available.';
        });
      }
    }
  }

  void _checkAnswer() {
    final currentQuestion = exercises[widget.exerciseIndex][_currentQuestionIndex];
    if (_spokenText.toLowerCase() == currentQuestion['correctAnswer']!.toLowerCase()) {
      setState(() {
        _correctAnswers++;
      });
    } else {
      setState(() {
        _incorrectAnswers++;
      });
    }
  }

  void _goToQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
      _spokenText = '';
      _isMicTapped = false;
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kết quả', style: TextStyle(fontSize: 24)),
          content: Text(
            'Số câu đúng: $_correctAnswers\nSố câu sai: $_incorrectAnswers',
            style: const TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                // Reset lại kết quả và câu hỏi
                setState(() {
                  _correctAnswers = 0;
                  _incorrectAnswers = 0;
                  _currentQuestionIndex = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = exercises[widget.exerciseIndex][_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập phát âm', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị biểu tượng loa và câu hỏi
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    color: _isSpeakerTapped ? Colors.cyan : Colors.black, // Đổi màu khi nhấn vào loa
                    size: 25, // Tăng kích thước biểu tượng loa
                  ),
                  onPressed: () {
                    setState(() {
                      _isSpeakerTapped = !_isSpeakerTapped; // Chuyển trạng thái loa
                    });
                    // Logic phát âm thanh câu hỏi (sử dụng TTS)
                  },
                ),
                Expanded(
                  child: Text(
                    currentQuestion['question']!,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Nút mic giống biểu tượng loa
            ElevatedButton(
              onPressed: _toggleListening,
              child: Icon(
                _isMicTapped ? Icons.mic_off : Icons.mic,
                size: 25,  // Tăng kích thước biểu tượng mic
                color: _isMicTapped ? Colors.cyanAccent : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Bạn đã nói: $_spokenText',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            if (_spokenText.isNotEmpty)
              Text(
                _spokenText.toLowerCase() == currentQuestion['correctAnswer']!.toLowerCase()
                    ? 'Đáp án đúng!'
                    : 'Đáp án sai!',
                style: TextStyle(
                  fontSize: 22,
                  color: _spokenText.toLowerCase() == currentQuestion['correctAnswer']!.toLowerCase()
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 20),
            // Nút chuyển câu hỏi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _goToQuestion(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentQuestionIndex == index ? Colors.blue : Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 16), // Giảm kích cỡ chữ nút xuống 16
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            // Nút hiển thị kết quả
            if (_currentQuestionIndex == 4)
              Center(
                child: ElevatedButton(
                  onPressed: _showResults,
                  child: const Text('Xem kết quả', style: TextStyle(fontSize: 20)), // Giảm kích cỡ chữ nút "Xem kết quả"
                ),
              ),
          ],
        ),
      ),
    );
  }
}
