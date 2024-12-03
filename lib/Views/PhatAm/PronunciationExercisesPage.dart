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
            appBar: AppBar(
              title: const Text("Bài tập phát âm"),
              backgroundColor: Colors.blue.shade700,
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: provider.hasPrevious
                    ? provider.previousQuestion
                    : () => Navigator.of(context).pop(),
                icon: Icon(
                    Icons.arrow_back, // Biểu tượng "next"
                    color: Colors.black // Màu của biểu tượng
                ),
                iconSize: 30, // Kích thước biểu tượng
              ),
              actions: [
                IconButton(
                  onPressed: provider.hasNext
                      ? provider.skipQuestion
                      : () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_forward, // Biểu tượng "next"
                    color: Colors.black // Màu của biểu tượng
                  ),
                  iconSize: 30, // Kích thước biểu tượng
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      question.question ?? '',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (question.type == "multiple-choice")
                      _buildMultipleChoice(context, question, provider),
                    if (question.type == "pronunciation")
                      _buildPronunciation(context, question, provider),
                    const SizedBox(height: 20),
                    if (question.type == "pronunciation")
                      _buildCard(provider.talkResult),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        provider.questions.length,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: provider.currentIndex == index
                                ? Colors.blue
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: provider.currentIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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
      PronunciationExercisesProvider provider) {
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
      PronunciationExercisesProvider provider) {
    var questionShow = question.question ?? '';
    var lengthCheck = questionShow
        .replaceAll(',', ' ')
        .replaceAll('?', ' ')
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
        if (provider.answer == '')
          Center(
            child: Text(
              questionShow,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        else
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildTextWidgets(lengthCheck, questionShow, provider.answer),
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

  Widget _buildCard(String rs) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              rs == '' ? 'Nơi hiện kết quả nói' :'Bạn đã nói',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              rs == '' ? 'Chúc may mắn' : rs,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
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
                  fontSize: 21,
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
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            );
          } else {
            textWidgets.add(
              Text(
                '${showChar[i]} ',
                style: const TextStyle(
                    fontSize: 21,
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
