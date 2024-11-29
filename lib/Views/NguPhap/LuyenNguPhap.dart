import 'dart:convert';
import 'package:dacn/Model/Grammar.dart';
import 'package:dacn/Model/Page.dart';
import 'package:dacn/Service/APICall/GrammarService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Views/NguPhap/BaiHocNguPhap.dart';
import 'package:flutter/material.dart';

class HomeNP extends StatefulWidget {
  const HomeNP({Key? key}) : super(key: key);

  @override
  _HomeNPState createState() => _HomeNPState();
}

class _HomeNPState extends State<HomeNP> {
  int currentPage = 1; // Trang hiện tại
  int maxPage = 1; // Tổng số trang
  List<Grammar> grammarList = []; // Danh sách bài học

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Bài học Ngữ pháp',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: GrammarService.getGrammarListOnPageAndLimit(page: currentPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Đã xảy ra lỗi khi tải dữ liệu.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu bài học nha, tải thất bại'));
          } else {
            // Lấy danh sách Grammar từ dữ liệu API
            final List<Grammar> newGrammarList =
                GetDataFromMap.getGrammarList(snapshot.data!) ?? [];
            final pageModel = GetDataFromMap.getPage(snapshot.data!) ?? PageModel();
            maxPage = pageModel.totalPages;

            if (newGrammarList.isEmpty) {
              return const Center(child: Text('Không có dữ liệu bài học.'));
            }

            grammarList = newGrammarList;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: grammarList.length,
                    itemBuilder: (context, index) {
                      final lesson = grammarList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BHNP(
                                lesson: lesson,
                                allLessons: grammarList, // Truyền toàn bộ danh sách
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: lesson.image == null || lesson.image!.isEmpty
                                    ? Image.asset(
                                  'assets/default_image.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                                    : Image.memory(
                                  base64Decode(lesson.image!),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lesson.title ?? 'Không có tiêu đề',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      lesson.description ?? 'Không có thông tin',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Hiển thị nút chuyển trang
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nút trước
                      if (currentPage > 1)
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              currentPage--;
                            });
                          },
                        ),
                      // Nút hiện tại
                      Text(
                        'Trang $currentPage',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Nút sau
                      if (currentPage < maxPage)
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            setState(() {
                              currentPage++;
                            });
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
