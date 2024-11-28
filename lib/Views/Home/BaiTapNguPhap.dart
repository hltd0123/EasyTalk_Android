import 'package:flutter/material.dart';

class BaiTapNguPhap extends StatefulWidget {
  const BaiTapNguPhap({super.key});

  @override
  _BaiTapNguPhapState createState() => _BaiTapNguPhapState();
}

class _BaiTapNguPhapState extends State<BaiTapNguPhap> {
  // Danh sách các bài tập ngữ pháp
  final List<Map<String, String>> grammarExercises = [
    {'title': 'Bài tập 1: Verb Forms', 'description': 'Chọn động từ đúng theo ngữ cảnh.'},
    {'title': 'Bài tập 2: Tenses', 'description': 'Chọn thì đúng cho câu.'},
    {'title': 'Bài tập 3: Prepositions', 'description': 'Điền giới từ phù hợp.'},
    {'title': 'Bài tập 4: Articles', 'description': 'Chọn mạo từ đúng.'},
    {'title': 'Bài tập 5: Conditional Sentences', 'description': 'Chọn câu điều kiện đúng.'},
  ];

  // Hàm điều hướng đến bài tập ngữ pháp cụ thể
  void _goToGrammarExercise(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrammarExercisePage(exerciseIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài tập ngữ pháp'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: grammarExercises.length,
        itemBuilder: (context, index) {
          final exercise = grammarExercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(
                exercise['title']!,
                style: const TextStyle(fontSize: 20),  // Tăng kích thước font chữ tiêu đề
              ),
              subtitle: Text(
                exercise['description']!,
                style: const TextStyle(fontSize: 16),  // Tăng kích thước font chữ mô tả
              ),
              onTap: () => _goToGrammarExercise(index),  // Khi chọn bài tập
            ),
          );
        },
      ),
    );
  }
}

class GrammarExercisePage extends StatefulWidget {
  final int exerciseIndex;

  const GrammarExercisePage({super.key, required this.exerciseIndex});

  @override
  _GrammarExercisePageState createState() => _GrammarExercisePageState();
}

class _GrammarExercisePageState extends State<GrammarExercisePage> {
  int _currentQuestionIndex = 0;  // Chỉ số câu hỏi hiện tại
  int _correctAnswers = 0;  // Số câu đúng
  int _incorrectAnswers = 0;  // Số câu sai

  // Các câu hỏi của bài tập
  List<Map<String, dynamic>> grammarQuestions = [
    {
      'question': 'Choose the correct verb form:'
          ' I ___ to school every day.',
      'options': ['go', 'goes', 'gone', 'went'],
      'correctAnswer': 'go',
    },
    {
      'question': 'Choose the correct sentence:'
          ' ___ you like to play football?',
      'options': ['Do', 'Does', 'Are', 'Is'],
      'correctAnswer': 'Do',
    },
    {
      'question': 'Choose the correct word: '
          'She is ___ than me.',
      'options': ['taller', 'more tall', 'tall', 'tallest'],
      'correctAnswer': 'taller',
    },
    {
      'question': 'Which sentence is correct?',
      'options': [
        'She can sings well.',
        'She can sing well.',
        'She sing can well.',
        'She well can sing.',
      ],
      'correctAnswer': 'She can sing well.',
    },
    {
      'question': 'Choose the correct word: '
          'I am very ___ today.',
      'options': ['happy', 'happily', 'happiness', 'happier'],
      'correctAnswer': 'happy',
    },
  ];

  // Hàm kiểm tra câu trả lời
  void _checkAnswer(String selectedAnswer) {
    final currentQuestion = grammarQuestions[_currentQuestionIndex];
    if (selectedAnswer == currentQuestion['correctAnswer']) {
      setState(() {
        _correctAnswers++;
      });
    } else {
      setState(() {
        _incorrectAnswers++;
      });
    }
  }

  // Chuyển sang câu hỏi tiếp theo
  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < grammarQuestions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  // Hiển thị kết quả
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
                // Reset lại bài tập sau khi xem kết quả
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
    final currentQuestion = grammarQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài tập ngữ pháp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị câu hỏi
            Text(
              currentQuestion['question']!,
              style: const TextStyle(
                fontSize: 22,  // Tăng kích thước font chữ câu hỏi
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị các lựa chọn
            for (var option in currentQuestion['options'])
              ElevatedButton(
                onPressed: () {
                  _checkAnswer(option);  // Kiểm tra câu trả lời
                  _goToNextQuestion();  // Chuyển sang câu hỏi tiếp theo
                },
                child: Text(option, style: const TextStyle(fontSize: 18)),  // Tăng kích thước font chữ lựa chọn
              ),
            const SizedBox(height: 20),
            // Thêm các nút 1, 2, 3, 4, 5 để chuyển câu hỏi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(grammarQuestions.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentQuestionIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentQuestionIndex == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            // Căn giữa nút Xem kết quả
            if (_currentQuestionIndex == grammarQuestions.length - 1)
              Center(
                child: ElevatedButton(
                  onPressed: _showResults,
                  child: const Text('Xem kết quả', style: TextStyle(fontSize: 18)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
