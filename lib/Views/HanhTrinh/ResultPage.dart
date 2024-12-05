import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswersCount; // Số câu trả lời đúng
  final int totalQuestions; // Tổng số câu hỏi
  final List<bool?> questionResult; // Danh sách kết quả của câu hỏi (true = đúng, false = sai)

  ResultPage({
    required this.correctAnswersCount,
    required this.totalQuestions,
    required this.questionResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kết quả của bạn:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Số câu trả lời đúng: $correctAnswersCount/$totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Danh sách kết quả:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Câu hỏi ${index + 1}'),
                    trailing: Icon(
                      questionResult[index] == true ? Icons.check : Icons.close,
                      color: questionResult[index] == true ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
