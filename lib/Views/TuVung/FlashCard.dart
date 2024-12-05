import 'package:dacn/Model/Page.dart';
import 'package:flutter/material.dart';
import 'package:dacn/Model/FlashCardList.dart';
import 'package:dacn/Service/APICall/FlashCardListService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Views/TuVung/FlashCardDetail.dart';

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final List<FlashCardList> _flashCardLists = [];
  PageModel _page = PageModel();
  bool _isLoading = false;

  // Hàm gọi dịch vụ để lấy danh sách FlashCard với phân trang
  void _loadFlashCards() async {
    setState(() {
      _isLoading = true;
    });

    final data = await FlashCardListService.getFlashCardListOnPage(page: _page.currentPage);
    List<FlashCardList> flashCards = GetDataFromMap.getFlashCardList(data) ?? [];
    PageModel page = GetDataFromMap.getPage(data) ?? PageModel();

    setState(() {
      _isLoading = false;
      _flashCardLists.addAll(flashCards);
      _page = page;
    });
  }

  // Hàm gọi màn hình tạo FlashCardList mới
  void _addFlashCardList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        String description = '';

        return AlertDialog(
          title: const Text('Tạo FlashCard List'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tên danh sách:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextField(
                  onChanged: (value) => name = value,
                  decoration: const InputDecoration(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text('Mô tả:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextField(
                  onChanged: (value) => description = value,
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
                if (name.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    _flashCardLists.add(FlashCardList(
                      name: name,
                      description: description,
                      wordCount: 0, // Số từ vựng mặc định là 0
                    ));
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

  // Hàm chuyển trang
  void _nextPage(int max) {
    if(_page.currentPage < max){
      setState(() {
        _page.currentPage++;
        _flashCardLists.clear();  // Xóa danh sách cũ trước khi tải trang mới
        _loadFlashCards();
      });
    }
  }

  void _previousPage() {
    if (_page.currentPage > 1) {
      setState(() {
        _page.currentPage--;
        _flashCardLists.clear();
        _loadFlashCards();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFlashCards(); // Load danh sách khi khởi tạo trang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Flash Card Lists',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: _addFlashCardList, // Mở màn hình tạo mới FlashCardList
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  _flashCardLists.isEmpty
                      ? 'Bạn chưa tạo FlashCard List nào'
                      : 'Danh sách FlashCard Lists',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _flashCardLists.length,
                itemBuilder: (context, index) {
                  final flashCard = _flashCardLists[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(flashCard.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mô tả: ${flashCard.description}'),
                          Text('Số từ vựng: ${flashCard.wordCount ?? 0}'),
                        ],
                      ),
                      onTap: () {
                        // Xử lý khi click vào một FlashCardList
                        _openDetailScreen(flashCard);
                      },
                    ),
                  );
                },
              ),
            ),
            // Hiển thị các nút chuyển trang
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _previousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Trang trước'),
                  ),
                  ElevatedButton(
                    onPressed: () => _nextPage(_page.totalPages),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Trang sau'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mở màn hình chi tiết
  void _openDetailScreen(FlashCardList flashCard) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlashCardDetail(flashCardList: flashCard),
      ),
    );
  }
}
