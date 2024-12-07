import 'package:flutter/material.dart';

Widget ExerciseCard({
  required BuildContext context,
  required String title,
  required VoidCallback onPressed,
  required int numQuestion,
  required String textButton}) {
  final screenHeight = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.only(
      bottom: screenHeight * 0.02,
    ),
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.22,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text("Số lượng câu hỏi: $numQuestion"),
            const Spacer(),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(textButton),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
