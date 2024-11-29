import 'dart:convert';

import 'package:dacn/Model/Grammar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BHNP extends StatelessWidget {
  final Grammar lesson;
  final List<Grammar> allLessons;

  const BHNP({
    super.key,
    required this.lesson,
    required this.allLessons,
  });

  @override
  Widget build(BuildContext context) {
    // Lọc ra danh sách các bài học liên quan, trừ bài học hiện tại
    final relatedLessons = allLessons.where((e) => e != lesson).toList();
    String domain = dotenv.env['domain']!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Không bóng
        backgroundColor: Colors.blue, // Màu nền
        automaticallyImplyLeading: true, // Hiển thị nút Back
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề dưới AppBar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                lesson.title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ảnh bài học
                  Image.memory(
                    base64Decode(lesson.image ?? ''),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  // Thông tin bài học
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlWidget(
                      lesson.content ?? '',
                      textStyle: TextStyle(fontSize: 16),
                      customWidgetBuilder: (element) {
                        // Xử lý thẻ <img>
                        if (element.localName == 'img') {
                          final src = element.attributes['src'];
                          if (src != null && src.isNotEmpty) {
                            return Image.network(domain + src);  // Hoặc Image.network(src) nếu là URL
                          } else {
                            return SizedBox.shrink(); // Tránh trả về null nếu không có ảnh
                          }
                        }

                        // Xử lý thẻ <table>
                        else if (element.localName == 'table') {
                          // Xử lý thẻ table
                          List<TableRow> rows = [];

                          // Lặp qua tất cả các thẻ tr trong bảng
                          for (var child in element.children) {
                            if (child.localName == 'thead' || child.localName == 'tbody') {
                              for (var tr in child.children) {
                                if (tr.localName == 'tr') {
                                  List<Widget> cells = [];
                                  for (var td in tr.children) {
                                    if (td.localName == 'td' || td.localName == 'th') {
                                      cells.add(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(td.text.trim(), style: TextStyle(fontSize: 14)),
                                        ),
                                      );
                                    }
                                  }
                                  rows.add(TableRow(children: cells));
                                }
                              }
                            }
                          }

                          return Table(
                            border: TableBorder.all(),
                            children: rows,
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  // Các bài học liên quan
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Các bài học liên quan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...relatedLessons.map((related) {
                    return ListTile(
                      leading: Image.memory(
                        base64Decode(related.image ?? ''),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(related.title ?? ''),
                      subtitle: Text(related.description ?? ''),
                      onTap: () {
                        // Chuyển đến BHNP mới khi nhấn
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BHNP(
                              lesson: related, // Truyền bài học được chọn
                              allLessons: allLessons, // Truyền danh sách đầy đủ
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
