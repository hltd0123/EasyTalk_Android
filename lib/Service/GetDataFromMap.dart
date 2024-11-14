import 'package:dacn/Model/FlashCardList.dart';
import 'package:dacn/Model/GrammarExercise.dart';
import 'package:dacn/Model/Journey.dart';
import 'package:dacn/Model/Leaderboard.dart';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Model/UserProgress.dart';

class GetDataFromMap{
  // Lấy danh sách GrammarExercise từ map
  static List<GrammarExercise>? getGrammarExercisesList(Map<String, dynamic> data) {
    return data['grammarExercises'];
  }

  static List<FlashCardList>? getFlashCardList(Map<String, dynamic> data) {
    return data['flashCardLists'];
  }

  // Lấy thông tin phân trang Page từ map
  static Page? getPage(Map<String, dynamic> data) {
    return data['page'];
  }

  // Phương thức giúp truy cập từng trường từ map trả về mà không cần vào class
  static Journey? getJourney(Map<String, dynamic> data) {
    return data['journey']; // Trả về danh sách Journey
  }

  static List<Journey>? getJourneyList(Map<String, dynamic> data) {
    return data['journeys']; // Trả về danh sách Journey
  }

  static UserProgress? getUserProgress(Map<String, dynamic> data) {
    return data['userProgress']; // Trả về thông tin tiến độ người dùng
  }

  static int? getCompletedGates(Map<String, dynamic> data) {
    return data['completedGates']; // Trả về số gates đã hoàn thành
  }

  static int? getCompletedStages(Map<String, dynamic> data) {
    return data['completedStages']; // Trả về số stages đã hoàn thành
  }

  static List<Leaderboard>? getLeaderboard(Map<String, dynamic> result) {
    return result['leaderboard']; // Trả về danh sách leaderboard
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
}