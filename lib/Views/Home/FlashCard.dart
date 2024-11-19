import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  // Danh sách flashcard
  final List<Map<String, String>> _flashCards = [];

  void _addFlashCard() {
    // Hàm thêm flashcard mới
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = ''; // Tiêu đề
        String content = ''; // Nội dung
        return AlertDialog(
          title: const Text('Tạo FlashCard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Để căn trái các phần tử
            children: [
              // Tiêu đề cho trường Tiêu đề
              const Text(
                'Tiêu đề:',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // In đậm
                  fontSize: 18,  // Cỡ chữ lớn hơn
                ),
              ),
              const SizedBox(height: 10),  // Khoảng cách giữa Tiêu đề và trường nhập liệu
              // Khung nhập liệu Tiêu đề
              TextField(
                onChanged: (value) {
                  title = value;  // Cập nhật Tiêu đề
                },
                decoration: const InputDecoration(
                ),
                style: const TextStyle(fontSize: 18), // Tăng kích thước chữ cho Tiêu đề
              ),
              const SizedBox(height: 20), // Khoảng cách giữa các phần
              // Tiêu đề cho trường Nội dung
              const Text(
                'Nội dung:',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // In đậm
                  fontSize: 18,  // Cỡ chữ lớn hơn
                ),
              ),
              const SizedBox(height: 10),  // Khoảng cách giữa Tiêu đề và trường nhập liệu
              // Khung nhập liệu Nội dung
              TextField(
                onChanged: (value) {
                  content = value;  // Cập nhật Nội dung
                },
                decoration: const InputDecoration(
                ),
                style: const TextStyle(fontSize: 18), // Tăng kích thước chữ cho Nội dung
                maxLines: 5,  // Cho phép người dùng nhập nhiều dòng
                minLines: 3,  // Giới hạn tối thiểu là 3 dòng
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Đóng hộp thoại
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  setState(() {
                    _flashCards.add({'front': title, 'back': content});
                  });
                  Navigator.of(context).pop();  // Đóng hộp thoại sau khi thêm flashcard
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
        title: const Text(
          'Flash Cards',  // Tiêu đề trên AppBar
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Tô đậm tiêu đề
            fontSize: 24,  // Cỡ chữ lớn hơn
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tiêu đề dưới AppBar
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _flashCards.isEmpty
                    ? 'Bạn chưa tạo FlashCard nào'  // Tiêu đề dưới AppBar khi chưa có flashcards
                    : 'Danh sách FlashCards',  // Tiêu đề khi có flashcards
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20), // Khoảng cách dưới tiêu đề
            // Nội dung chính
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
                      title: Text(flashCard['front']!),
                      subtitle: Text(flashCard['back']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _flashCards.removeAt(index); // Xóa FlashCard
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
        onPressed: _addFlashCard,  // Khi nhấn vào sẽ hiển thị hộp thoại để thêm flashcard
        child: const Icon(Icons.add),
      ),
    );
  }
}
