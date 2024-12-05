import 'dart:convert';

import 'package:dacn/Model/FlashCard.dart';
import 'package:dacn/Model/FlashCardList.dart';
import 'package:dacn/Router/AppRouter.dart';
import 'package:dacn/Service/APICall/FlashCardService.dart';
import 'package:flutter/material.dart';

class FlashCardDetail extends StatefulWidget {
  final FlashCardList flashCardList;

  const FlashCardDetail({super.key, required this.flashCardList});

  @override
  _FlashCardDetailState createState() => _FlashCardDetailState();
}

class _FlashCardDetailState extends State<FlashCardDetail> {
  late Future<List<FlashCard>> _flashCardList;

  @override
  void initState() {
    super.initState();
    _flashCardList = FlashCardService.getFlashCardListOnId(id: widget.flashCardList.id ?? '', limit: 1000);
  }

  void _addWord() {
    String word = '';
    String pronunciation = '';
    String meaning = '';
    String pos = '';
    String exampleSentence = '';
    String image = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thêm từ mới'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Từ vựng:'),
                TextField(
                  onChanged: (value) => word = value,
                  decoration: const InputDecoration(hintText: 'Nhập từ vựng'),
                ),
                const SizedBox(height: 16),
                const Text('Phiên âm:'),
                TextField(
                  onChanged: (value) => pronunciation = value,
                  decoration: const InputDecoration(hintText: 'Nhập phiên âm'),
                ),
                const SizedBox(height: 16),
                const Text('Nghĩa:'),
                TextField(
                  onChanged: (value) => meaning = value,
                  decoration: const InputDecoration(hintText: 'Nhập nghĩa'),
                ),
                const SizedBox(height: 16),
                const Text('Loại từ vựng:'),
                DropdownButton<String>(
                  value: pos,
                  onChanged: (String? newValue) {
                    setState(() {
                      pos = newValue!;
                    });
                  },
                  items: <String>['Danh từ', 'Động từ', 'Tính từ', 'Trạng từ']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Ví dụ câu:'),
                TextField(
                  onChanged: (value) => exampleSentence = value,
                  decoration: const InputDecoration(hintText: 'Nhập ví dụ câu'),
                ),
                const SizedBox(height: 16),
                const Text('Ảnh :'),
                TextField(
                  onChanged: (value) => image = value,
                  decoration: const InputDecoration(hintText: 'Nhập ảnh ở dạng Base64'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (word.isNotEmpty && pronunciation.isNotEmpty && meaning.isNotEmpty && pos.isNotEmpty && exampleSentence.isNotEmpty && image.isNotEmpty) {
                  setState(() {
                    FlashCard newFlashCard = FlashCard(
                      word: word,
                      pronunciation: pronunciation,
                      meaning: meaning,
                      pos: pos,
                      exampleSentence: exampleSentence,
                      image: image,
                    );
                    FlashCardService.addFlashCard(newFlashCard, widget.flashCardList.id ?? widget.flashCardList.id!);
                    widget.flashCardList.wordCount++;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Từ vựng đã được thêm thành công!')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin!")));
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.flashCardList.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: _addWord,
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<FlashCard>>(
          future: _flashCardList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              var flashCards = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Số từ vựng: ${widget.flashCardList.wordCount}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouter.flashcardstudying,
                        arguments: flashCards),
                    child: const Text('Nhấn để học'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: flashCards.length,
                      itemBuilder: (context, index) {
                        final flashCard = flashCards[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height * 0.3, // Chiều cao tối thiểu là 30% chiều cao màn hình
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    flashCard.word,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Loại: ${flashCard.pos} - Phiên âm: ${flashCard.pronunciation}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Nghĩa: ${flashCard.meaning}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Ví dụ: ${flashCard.exampleSentence}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.center,
                                  child: flashCard.image.isNotEmpty
                                      ? Image.memory(
                                    base64Decode(flashCard.image),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Không có dữ liệu.'));
            }
          },
        ),
      ),
    );
  }
}
