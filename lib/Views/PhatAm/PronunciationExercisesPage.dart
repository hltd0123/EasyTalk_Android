import 'package:dacn/Model/PronunciationExercisesQuestion.dart';
import 'package:dacn/Views/PhatAm/PronunciationExercisesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class PronunciationExercisesPage extends StatelessWidget {
  final List<PronunciationExercisesQuestion> questions;
  final String exerciseId;

  const PronunciationExercisesPage({super.key, required this.questions, required this.exerciseId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PronunciationExercisesProvider(questions: questions, exerciseId: exerciseId),
      child: Consumer<PronunciationExercisesProvider>(
        builder: (context, provider, child) {
          final question = provider.currentQuestion;

          return Scaffold(
            appBar: AppBar(title: const Text("Luyện tập nghe và phát âm")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Question ${provider.currentIndex + 1}/${provider.questions.length}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  if (question.type == "multiple-choice")
                    _buildMultipleChoice(context, question, provider),
                  if (question.type == "pronunciation")
                    _buildPronunciation(context, question, provider),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    //Chuyển trang sau khi xong ở đây
                    onPressed: provider.hasNext ? provider.skipQuestion : Navigator.of(context).pop,
                    child: provider.hasNext ? const Text("Skip") : const Text("Kết thúc kiểm tra"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMultipleChoice(
      BuildContext context,
      PronunciationExercisesQuestion question,
      PronunciationExercisesProvider provider,
      ){
    FlutterTts flutterTts = FlutterTts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await flutterTts.setLanguage("en-US");
            await flutterTts.setPitch(1.0);
            await flutterTts.speak(question.question ?? '');
          },
          child: const Text('Nhấn để nghe phát âm'),
        ),
        const SizedBox(height: 10),
        ...?question.options?.map((option) => ElevatedButton(
          onPressed: () => provider.selectOption(option),
          child: Text(option),
        )),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: provider.selectedOption == null ? null : provider.checkAnswer,
          child: const Text("Kiểm tra"),
        ),
        if (provider.answerChecked != null)
          Text(
            provider.answerChecked! ? "Chính xác!" : "Sai rùi.",
            style: TextStyle(color: provider.answerChecked! ? Colors.green : Colors.red),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPronunciation(
      BuildContext context,
      PronunciationExercisesQuestion question,
      PronunciationExercisesProvider provider,
      ) {
    var questionShow = question.question ?? '';
    var lengthCheck = questionShow
        .replaceAll(',', '')  // Loại bỏ dấu phẩy
        .replaceAll('?', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .split(' ')
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Phát âm từ sau:",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        if(provider.answer == '')
          Center(
            child: Text(
              questionShow,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        else
          Center(
            child: Row(
              children: [
                // Tạo danh sách các widget Text trước khi thêm vào Row
                ..._buildTextWidgets(lengthCheck, questionShow, provider.answer),
              ],
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: provider.recording ? null : provider.startRecording,
          child: const Text("Ghi âm"),
        ),
        if (provider.recording)
          const Text(
            "Đang ghi ...",
            style: TextStyle(color: Colors.blue),
          ),
        if (provider.sending)
          const Text(
            "Đang gửi kết quả đi và lấy về ...",
            style: TextStyle(color: Colors.blue),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: !provider.recording ? null : provider.stopRecording,
          child: const Text("Dừng ghi âm và kiểm tra"),
        ),
      ],
    );
  }

  List<Widget> _buildTextWidgets(int lengthCheck, String dataShow, String dataCheck) {
    List<Widget> textWidgets = [];
    var showChar = dataShow
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .split(' ');
    for (int i = 0; i < showChar.length; i++) {
      switch (showChar[i]) {
        case '?':
        case '!':
        case ',':
          textWidgets.add(
            Text(
              '${showChar[i]} ',
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          );
          showChar.removeAt(i);
          i--;
          break;
        default:
          if (dataCheck[i] == 'T') {
            textWidgets.add(
              Text(
                '${showChar[i]} ',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            );
          }
          else {
            textWidgets.add(
              Text(
                '${showChar[i]} ',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            );
          }
      }
    }
    return textWidgets;
  }
}
