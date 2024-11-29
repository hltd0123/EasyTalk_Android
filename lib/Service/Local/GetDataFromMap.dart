import 'package:dacn/Model/DictationExercise.dart';
import 'package:dacn/Model/FlashCardList.dart';
import 'package:dacn/Model/Grammar.dart';
import 'package:dacn/Model/GrammarExercise.dart';
import 'package:dacn/Model/Journey.dart';
import 'package:dacn/Model/Leaderboard.dart';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/Pronunciation.dart';
import 'package:dacn/Model/PronunciationExercises.dart';
import 'package:dacn/Model/Stage.dart';
import 'package:dacn/Model/UserProgress.dart';
import 'package:dacn/Model/Vocabulary.dart';

class GetDataFromMap{
  static List<GrammarExercise>? getGrammarExercisesList(Map<String, dynamic> data) {
    return data['grammarExercises'];
  }

  static List<FlashCardList>? getFlashCardList(Map<String, dynamic> data) {
    return data['flashCardLists'];
  }

  static PageModel? getPage(Map<String, dynamic> data) {
    return data['page'];
  }

  static Journey? getJourney(Map<String, dynamic> data) {
    return data['journey'];
  }

  static List<Journey>? getJourneyList(Map<String, dynamic> data) {
    return data['journeys'];
  }

  static UserProgress? getUserProgress(Map<String, dynamic> data) {
    return data['userProgress'];
  }

  static int? getCompletedGates(Map<String, dynamic> data) {
    return data['completedGates'];
  }

  static int? getCompletedStages(Map<String, dynamic> data) {
    return data['completedStages'];
  }

  static List<Leaderboard>? getLeaderboard(Map<String, dynamic> result) {
    return result['leaderboard'];
  }

  static List<Pronunciation>? getPronunciations(Map<String, dynamic> result) {
    return result['pronunciations'];
  }

  static dynamic getUser(Map<String, dynamic> data) {
    return data['user'];
  }

  static dynamic getAchievements(Map<String, dynamic> data) {
    return data['achievements'];
  }

  static int? getTotalStages(Map<String, dynamic> data) {
    return data['totalStages'];
  }

  static int? getTotalGates(Map<String, dynamic> data) {
    return data['totalGates'];
  }

  static double? getProgressPercentage(Map<String, dynamic> data) {
    return data['progressPercentage'];
  }

  static List<PronunciationExercises>? getPronunciationExercisesList(Map<String, dynamic> data) {
    return data['PronunciationExercisesList'];
  }

  static Stage? getStage(Map<String, dynamic> data) {
    return data['stage'];
  }

  static List<Vocabulary>? getVocabularyList(Map<String, dynamic> data) {
    return data['vocabularies'];
  }

  static List<Grammar>? getGrammarList(Map<String, dynamic> data) {
    return data['grammars'];
  }

  static List<DictationExercise>? getDictationExercise(Map<String, dynamic> data) {
    return data['dictationExercises'];
  }
}