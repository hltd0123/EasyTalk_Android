import 'package:dacn/Model/GrammarExercise.dart';
import 'package:dacn/Model/GrammarExerciseQuestion.dart';
import 'package:dacn/Views/HanhTrinh/ResultPage.dart';
import 'package:dacn/Views/WidgetBuiding/customPageRoute.dart';
import 'package:flutter/cupertino.dart';

class GrammarExerciseProvider extends ChangeNotifier {
  final List<GrammarExerciseQuestion> grammarExerciseQuestion;
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0; // Số câu trả lời đúng
  List<bool?> questionResult;
  List<String> answered;
  int numQuestionAnswer = 0;
  int maxQuestion;

  GrammarExerciseProvider(this.grammarExerciseQuestion)
      : questionResult = List.filled(grammarExerciseQuestion.length, null),
        answered = List.filled(grammarExerciseQuestion.length, ''),
        maxQuestion = grammarExerciseQuestion.length;

  void setAnswer(String option) {
    answered[currentQuestionIndex] = option;
    notifyListeners();
  }

  void checkAnswer(String answer, GrammarExerciseQuestion currentQuestion) {
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
    if (index >= 0 && index < grammarExerciseQuestion.length) {
      currentQuestionIndex = index;
      notifyListeners();
    }
  }

  bool? isQuestionResult(int index) {
    return questionResult[index];
  }
}