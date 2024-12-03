import 'package:dacn/Model/Stage.dart';
import 'package:dacn/Service/APICall/StageService.dart';
import 'package:dacn/Views/HanhTrinh/ResultPage.dart';
import 'package:dacn/Views/WidgetBuiding/customPageRoute.dart';
import 'package:flutter/cupertino.dart';

class QuestionStageProvider extends ChangeNotifier {
  final List<QuestionStage> questionStage;
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0; // Số câu trả lời đúng
  List<bool?> questionResult;
  List<String> answered;
  int numQuestionAnswer = 0;
  int maxQuestion;

  QuestionStageProvider(this.questionStage)
      : questionResult = List.filled(questionStage.length, null),
        answered = List.filled(questionStage.length, ''),
        maxQuestion = questionStage.length;

  void setAnswer(String option){
    answered[currentQuestionIndex] = option;
    notifyListeners();
  }
  // Kiểm tra câu trả lời và đánh dấu câu hỏi đã làm
  void checkAnswer(String answer, QuestionStage currentQuestion) {
    if (currentQuestion.correctAnswer == answer) {
      correctAnswersCount++;
      questionResult[currentQuestionIndex] = true;
    }
    else{
      questionResult[currentQuestionIndex] = false;
    }
    numQuestionAnswer ++;
    notifyListeners();
  }

  Future<void> endQuestion(BuildContext context, String stageId) async {
    await StageService.setCompleteState(stageId);
    Navigator.pushReplacement(context, customPageRoute(
        ResultPage(correctAnswersCount: correctAnswersCount,
            totalQuestions: maxQuestion,
            questionResult: questionResult
        )
      )
    );
  }
  void goToQuestion(int index) {
    if (index >= 0 && index < questionStage.length) {
      currentQuestionIndex = index;
      notifyListeners();
    }
  }

  bool? isQuestionResult(int index) {
    return questionResult[index];
  }

}
