import 'package:dacn/Model/PronunciationExercises.dart';
import 'package:dacn/Service/APICall/PronunciationExercisesService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Views/WidgetBuiding/CustomSearchAppBar.dart';
import 'package:dacn/Views/WidgetBuiding/PronunciationExcerciseListGenerate.dart';
import 'package:flutter/material.dart';

class ExerciseListPagePhatAm extends StatefulWidget {
  const ExerciseListPagePhatAm({super.key});

  @override
  State<ExerciseListPagePhatAm> createState() => _ExerciseListPagePhatAmState();
}

class _ExerciseListPagePhatAmState extends State<ExerciseListPagePhatAm> {
  late Future<List<PronunciationExercises>> _pronunciationExerciseList;

  @override
  void initState() {
    _pronunciationExerciseList = fetchPronunciationExercise();
    super.initState();
  }

  Future<List<PronunciationExercises>> fetchPronunciationExercise() async {
    try {
      final data = await PronunciationExercisesService.getPronunciationExercises();
      List<PronunciationExercises> pronunciationExercises = GetDataFromMap.getPronunciationExercisesList(data) ?? [];
      for(var e in pronunciationExercises){
        print(e.id);
      }
      return pronunciationExercises;
    } catch (e) {
      throw Exception('Failed to load pronunciationsExcercise: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSearchAppBar(hintText: 'Tìm kiếm...'),
          PronunciationExcerciseListGenerate(pronunciationList: _pronunciationExerciseList),
        ],
      ),
    );
  }
}
