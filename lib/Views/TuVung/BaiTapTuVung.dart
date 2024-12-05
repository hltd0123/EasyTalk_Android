import 'package:dacn/Service/APICall/VocabularyExerciseService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Views/TuVung/VocabularyExerciseProvider.dart';
import 'package:flutter/material.dart';
import 'package:dacn/Model/Vocabulary.dart';
import 'package:provider/provider.dart';

class BaiTapTuVung extends StatefulWidget {
  const BaiTapTuVung({super.key});

  @override
  _BaiTapTuVungState createState() => _BaiTapTuVungState();
}

class _BaiTapTuVungState extends State<BaiTapTuVung> {
  final Future<Map<String, dynamic>?> dataExGet =
  VocabularyExerciseService.getVocabularyExercisesOnPageAndLimit();

  void _goToVocabularyExercise(Vocabulary vocabulary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VocabularyExercisePage(vocabulary: vocabulary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách bài tập từ vựng'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: dataExGet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final exercises =
                GetDataFromMap.getVocabularyList(snapshot.data!) ?? [];

            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Text(
                      exercise.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: const Text(
                      'Mô tả bài tập',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => _goToVocabularyExercise(exercise),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}

class VocabularyExercisePage extends StatefulWidget {
  final Vocabulary vocabulary;

  const VocabularyExercisePage({
    Key? key,
    required this.vocabulary,
  }) : super(key: key);

  @override
  State<VocabularyExercisePage> createState() =>
      _VocabularyExercisePageState();
}

class _VocabularyExercisePageState extends State<VocabularyExercisePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VocabularyExerciseProvider(widget.vocabulary.questions),
      child: Consumer<VocabularyExerciseProvider>(
        builder: (context, provider, _) {
          final currentQuestion =
          provider.vocabularyQuestion[provider.currentQuestionIndex];
          int numQuestion = provider.vocabularyQuestion.length;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Bài kiểm tra từ vựng'),
              backgroundColor: Colors.blue.shade700,
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    if (await _showExitDialog(context)) {
                      await provider.endQuestion(context);
                    }
                  },
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      currentQuestion.question,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (currentQuestion.type == 'multiple-choice')
                    _buildMultipleChoice(
                        currentQuestion.options, provider)
                  else if (currentQuestion.type == 'translation' ||
                      currentQuestion.type == 'fill-in-the-blank')
                    _buildTranslationAndFill(provider),

                  const SizedBox(height: 20),

                  if (provider.isQuestionResult(
                      provider.currentQuestionIndex) ==
                      null)
                    ElevatedButton(
                      onPressed: () {
                        provider.checkAnswer(
                          textController.text,
                          currentQuestion,
                        );
                      },
                      child: const Text('Kiểm tra đáp án'),
                    ),

                  if (provider.isQuestionResult(
                      provider.currentQuestionIndex) !=
                      null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          if (provider.isQuestionResult(
                              provider.currentQuestionIndex)!)
                            const Text(
                              'Chính xác!',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.greenAccent),
                            )
                          else
                            const Text(
                              'Sai rùi!',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.redAccent),
                            ),
                          Text(
                            'Giải thích: ${currentQuestion.explanation}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),

                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      numQuestion,
                          (index) => GestureDetector(
                        onTap: () {
                          textController.text = provider.answered[index];
                          provider.goToQuestion(index);
                        },
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: provider.currentQuestionIndex == index
                                ? Colors.blue
                                : (provider.isQuestionResult(index) == null
                                ? Colors.grey.shade300
                                : (provider.isQuestionResult(index) ==
                                false
                                ? Colors.red.shade300
                                : Colors.green)),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: provider.currentQuestionIndex ==
                                    index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    bool? exit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thoát/Kết thúc'),
          content: const Text('Muốn kết thúc thật không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );

    return exit ?? false;
  }

  Widget _buildMultipleChoice(
      List<String> options, VocabularyExerciseProvider provider) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: options.asMap().entries.map((entry) {
        String option = entry.value;
        return ElevatedButton(
          onPressed: () {
            if (provider.isQuestionResult(provider.currentQuestionIndex) ==
                null) {
              provider.setAnswer(option);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
            provider.answered[provider.currentQuestionIndex] == option
                ? Colors.green
                : Colors.white,
          ),
          child: Text(
            option,
            style: TextStyle(
              color: provider.answered[provider.currentQuestionIndex] ==
                  option
                  ? Colors.black
                  : Colors.blueAccent,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTranslationAndFill(VocabularyExerciseProvider provider) {
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Xin câu trả lời nha...',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
