import 'package:dacn/Model/Gate.dart';

class Journey {
  String id;
  String title;
  List<Gate> gates;
  int progressPercentage;

  Journey({
    required this.id,
    required this.title,
    required this.gates,
    required this.progressPercentage
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['_id'],
      title: json['title'],
      gates: List<Gate>.from(json['gates'].map((x) => Gate.fromJson(x))),
      progressPercentage: json['progressPercentage'] ?? 0,
    );
  }
}
