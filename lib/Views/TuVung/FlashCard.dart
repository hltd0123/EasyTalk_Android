import 'package:flutter/material.dart';
import 'package:dacn/Views/TuVung/FlashCardDetail.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  final List<Map<String, String>> _flashCards = [];

  void _addFlashCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String content = '';

        return AlertDialog(
          title: const Text('Tạo FlashCard'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tiêu đề:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) => title = value,
                  decoration: const InputDecoration(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nội dung:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) => content = value,
                  decoration: const InputDecoration(),
                  style: const TextStyle(fontSize: 18),
                  maxLines: 3,
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
                if (title.isNotEmpty && content.isNotEmpty) {
                  setState(() {
                    _flashCards.add({
                      'title': title,
                      'content': content,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  void _openDetailScreen(Map<String, String> flashCard) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashCardDetail(flashCard: flashCard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flash Cards',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: _flashCards.isNotEmpty
            ? [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: _addFlashCard,
          ),
        ]
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _flashCards.isEmpty
                    ? 'Bạn chưa tạo FlashCard nào'
                    : 'Danh sách FlashCards',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _flashCards.isEmpty
                  ? Center(
                child: GestureDetector(
                  onTap: _addFlashCard,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: _flashCards.length,
                itemBuilder: (context, index) {
                  final flashCard = _flashCards[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(flashCard['title']!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nội dung: ${flashCard['content']}'),
                          Text(
                            'Số từ vựng: 0', // Số từ vựng mặc định là 0
                          ),
                        ],
                      ),
                      onTap: () => _openDetailScreen(flashCard),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _flashCards.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashCard,
        child: const Icon(Icons.add),
      ),
    );
  }
}

