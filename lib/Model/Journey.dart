import 'package:dacn/Model/Gate.dart';

class Journey {
  String id;
  String title;
  List<Gate> gates;

  Journey({
    required this.id,
    required this.title,
    required this.gates,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['_id'],
      title: json['title'],
      gates: List<Gate>.from(json['gates'].map((x) => Gate.fromJson(x))),
    );
  }
}
