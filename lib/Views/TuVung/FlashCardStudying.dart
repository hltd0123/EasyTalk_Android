import 'package:dacn/Model/FlashCard.dart';
import 'package:dacn/Views/TuVung/FlashCardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:convert';

class FlashCardStudying extends StatelessWidget {
  final List<FlashCard> flashCards;

  const FlashCardStudying({Key? key, required this.flashCards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => FlashCardProvider(List.from(flashCards)),
      child: Scaffold(
        body: Consumer<FlashCardProvider>(
          builder: (context, flashCardProvider, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flash Cards'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shuffle),
                    onPressed: () {
                      flashCardProvider.shuffleFlashCards();
                    },
                  ),
                ],
                backgroundColor: Colors.teal,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flip Card
                  Expanded(
                    child: Center(
                      child: FlipCard(
                        key: ValueKey(flashCardProvider.currentFlashCard),
                        front: _buildCardFront(flashCardProvider.currentFlashCard, size),
                        back: _buildCardBack(flashCardProvider.currentFlashCard, size),
                      ),
                    ),
                  ),
                  if (flashCardProvider.showExample)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        flashCardProvider.currentFlashCard.exampleSentence,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.normal, color: Colors.black54),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        flashCardProvider.toggleExample();
                      },
                      child: const Text(
                        'XEM VÍ DỤ',  // Chữ "XEM VÍ DỤ" sẽ luôn xuất hiện
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  // Nút chức năng
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: flashCardProvider.currentIndex > 0
                              ? flashCardProvider.previousFlashCard
                              : null,
                          child: const Text('Quay lại'),
                        ),
                        ElevatedButton(
                          onPressed: flashCardProvider.removeCurrentFlashCard,
                          child: const Text('Loại bỏ'),
                        ),
                        ElevatedButton(
                          onPressed: flashCardProvider.currentIndex < flashCardProvider.flashCardCount - 1
                              ? flashCardProvider.nextFlashCard
                              : null,
                          child: const Text('Tiếp theo'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFront(FlashCard flashCard, Size size) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black45,
      color: Colors.orange.shade200,
      child: Container(
        height: size.height * 0.4,
        width: size.width * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (flashCard.image.isNotEmpty)
              Column(
                children: [
                  Image.memory(
                    const Base64Decoder().convert(flashCard.image),
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            Text(
              '${flashCard.word} (${flashCard.pos})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '/${flashCard.pronunciation}/',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBack(FlashCard flashCard, Size size) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black45,
      color: Colors.green.shade200,
      child: Container(
        height: size.height * 0.4,
        width: size.width * 0.8,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            flashCard.meaning,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

