import 'package:dacn/Model/PronunciationExercises.dart';
import 'package:dacn/Views/PhatAm/PronunciationExercisesPage.dart';
import 'package:dacn/Views/WidgetBuiding/ExerciseCard.dart';
import 'package:flutter/material.dart';

class PronunciationExcerciseListGenerate extends StatelessWidget {
  final Future<List<PronunciationExercises>> pronunciationList;

  const PronunciationExcerciseListGenerate({Key? key, required this.pronunciationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PronunciationExercises>>(
      future: pronunciationList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text('No pronunciation exercises found')),
          );
        } else {
          final pronunciationExercises = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final pronunciationExercise = pronunciationExercises[index];
                return ExerciseCard(
                  numQuestion: pronunciationExercise.questions?.length ?? 0,
                  context: context,
                  title: pronunciationExercise.title!,
                  textButton: "Kiểm tra nào",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PronunciationExercisesPage(questions: pronunciationExercise.questions ?? [], exerciseId: pronunciationExercise.id ?? '',);
                    },));
                  },
                );
              },
              childCount: pronunciationExercises.length,
            ),
          );
        }
      },
    );
  }
}
