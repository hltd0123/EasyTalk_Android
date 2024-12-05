import 'package:dacn/Model/VocabularyQuestion.dart';
import 'package:dacn/Views/HanhTrinh/ResultPage.dart';
import 'package:dacn/Views/WidgetBuiding/customPageRoute.dart';
import 'package:flutter/cupertino.dart';

class VocabularyExerciseProvider extends ChangeNotifier {
  final List<VocabularyQuestion> vocabularyQuestion;
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0; // Số câu trả lời đúng
  List<bool?> questionResult;
  List<String> answered;
  int numQuestionAnswer = 0;
  int maxQuestion;

  VocabularyExerciseProvider(this.vocabularyQuestion)
      : questionResult = List.filled(vocabularyQuestion.length, null),
        answered = List.filled(vocabularyQuestion.length, ''),
        maxQuestion = vocabularyQuestion.length;

  void setAnswer(String option) {
    answered[currentQuestionIndex] = option;
    notifyListeners();
  }

  void checkAnswer(String answer, VocabularyQuestion currentQuestion) {
    if (currentQuestion.correctAnswer == answer) {
      correctAnswersCount++;
      questionResult[currentQuestionIndex] = true;
    } else {
      questionResult[currentQuestionIndex] = false;
    }
    setAnswer(answer);
    numQuestionAnswer++;
    notifyListeners();
  }

  Future<void> endQuestion(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      customPageRoute(
        ResultPage(
          correctAnswersCount: correctAnswersCount,
          totalQuestions: maxQuestion,
          questionResult: questionResult,
        ),
      ),
    );
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < vocabularyQuestion.length) {
      currentQuestionIndex = index;
      notifyListeners();
    }
  }

  bool? isQuestionResult(int index) {
    return questionResult[index];
  }
}
