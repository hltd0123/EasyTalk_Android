import 'package:flutter/material.dart';

class FlashCardDetail extends StatefulWidget {
  final Map<String, dynamic> flashCard;

  const FlashCardDetail({super.key, required this.flashCard});

  @override
  _FlashCardDetailState createState() => _FlashCardDetailState();
}

class _FlashCardDetailState extends State<FlashCardDetail> {
  int vocabularyCount = 0;

  @override
  void initState() {
    super.initState();
    vocabularyCount = widget.flashCard['vocabulary'] ?? 0;
  }

  void _addWord() {
    String word = '';
    String pronunciation = '';
    String meaning = '';
    String wordType = 'Danh từ'; // Mặc định là Danh từ

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
                  value: wordType,
                  onChanged: (String? newValue) {
                    setState(() {
                      wordType = newValue!;
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
                if (word.isNotEmpty && pronunciation.isNotEmpty && meaning.isNotEmpty) {
                  setState(() {
                    // Thêm từ vựng vào danh sách của flashCard
                    widget.flashCard['words'] ??= [];  // Nếu chưa có từ vựng, tạo danh sách trống
                    widget.flashCard['words'].add({
                      'word': word,
                      'pronunciation': pronunciation,
                      'meaning': meaning,
                      'type': wordType,
                    });

                    // Cập nhật số từ vựng
                    vocabularyCount = widget.flashCard['words'].length;
                    widget.flashCard['vocabulary'] = vocabularyCount;  // Cập nhật lại số từ vựng
                  });
                  Navigator.of(context).pop();  // Đóng hộp thoại sau khi thêm

                  // Hiển thị thông báo thành công
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Từ vựng đã được thêm thành công!')),
                  );
                } else {
                  // Hiển thị thông báo nếu có trường nào trống
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin!")),
                  );
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
          widget.flashCard['title'] ?? 'Chi Tiết FlashCard',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Số từ vựng dưới AppBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Số từ vựng: $vocabularyCount',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị nút thêm + ở giữa màn hình
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: _addWord,
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
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị danh sách các từ vựng đã thêm
            Expanded(
              flex: 2,
              child: widget.flashCard['words']?.isEmpty ?? true
                  ? Center(
                child: Text('Chưa có từ vựng nào.'),
              )
                  : ListView.builder(
                itemCount: widget.flashCard['words'].length,
                itemBuilder: (context, index) {
                  final word = widget.flashCard['words'][index];
                  return ListTile(
                    title: Text(word['word']),
                    subtitle: Text('Loại: ${word['type']} - Phiên âm: ${word['pronunciation']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
