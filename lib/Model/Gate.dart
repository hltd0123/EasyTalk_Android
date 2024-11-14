import 'package:dacn/Model/Stage.dart';

class Gate {
  String id;
  String title;
  List<Stage> stages;

  Gate({
    required this.id,
    required this.title,
    required this.stages,
  });

  factory Gate.fromJson(Map<String, dynamic> json) {
    return Gate(
      id: json['_id'],
      title: json['title'],
      stages: List<Stage>.from(json['stages'].map((x) => Stage.fromJson(x))),
    );
  }
}