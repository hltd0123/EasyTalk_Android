import 'package:dacn/Model/Gate.dart';

class Journey {
  String id;
  String title;
  List<Gate> gates;
  double progressPercentage;

  Journey({
    required this.id,
    required this.title,
    required this.gates,
    required this.progressPercentage
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    var i = json['progressPercentage'] ?? 0;
    double per = 0;
    if(i is int){
      per = i.toDouble();
    }
    else {
      per = i;
    }
    return Journey(
      id: json['_id'],
      title: json['title'],
      gates: List<Gate>.from(json['gates'].map((x) => Gate.fromJson(x))),
      progressPercentage: per,
    );
  }
}
