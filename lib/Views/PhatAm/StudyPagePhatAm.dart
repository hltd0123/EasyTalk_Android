import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dacn/Views/PhatAm/PracticeExerCisePage.dart';

class StudyPagePhatAm extends StatefulWidget {
  const StudyPagePhatAm({super.key});

  @override
  _StudyPagePhatAmState createState() => _StudyPagePhatAmState();
}

class _StudyPagePhatAmState extends State<StudyPagePhatAm> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  bool _isSpeakerTapped = false;
  bool _isMicTapped = false;
  int _currentQuestionIndex = 0;

  int _correctAnswers = 0;  // Số câu đúng
  int _incorrectAnswers = 0;  // Số câu sai

  // Danh sách các bài tập phát âm
  final List<Map<String, String>> pronunciationExercises = [
    {'title': 'Bài tập phát âm 1', 'description': 'Phát âm các từ đơn giản'},
    {'title': 'Bài tập phát âm 2', 'description': 'Phát âm các từ khó hơn'},
    {'title': 'Bài tập phát âm 3', 'description': 'Phát âm các câu đầy đủ'},
  ];

  // Danh sách câu hỏi cho các bài tập phát âm
  final List<List<Map<String, String>>> exercises = [
    [ // Bài tập phát âm 1
      {'question': 'Say "sip"', 'correctAnswer': 'sip'},
      {'question': 'Say "she"', 'correctAnswer': 'she'},
      {'question': 'Say "think"', 'correctAnswer': 'think'},
    ],
    [ // Bài tập phát âm 2
      {'question': 'Say "juice"', 'correctAnswer': 'juice'},
      {'question': 'Say "bat"', 'correctAnswer': 'bat'},
      {'question': 'Say "fish"', 'correctAnswer': 'fish'},
    ],
    [ // Bài tập phát âm 3
      {'question': 'Say "I like ice cream"', 'correctAnswer': 'I like ice cream'},
      {'question': 'Say "She is going to school"', 'correctAnswer': 'She is going to school'},
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
    final currentQuestion = exercises[_currentQuestionIndex][_currentQuestionIndex];
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
          title: const Text('Kết quả'),
          content: Text(
            'Số câu đúng: $_correctAnswers\nSố câu sai: $_incorrectAnswers',
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài tập phát âm'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: pronunciationExercises.length,
        itemBuilder: (context, index) {
          final exercise = pronunciationExercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(
                exercise['title']!,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                exercise['description']!,
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Khi nhấn vào bài tập, hiển thị giao diện bài tập tương ứng
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeExercisePage(exerciseIndex: index),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
