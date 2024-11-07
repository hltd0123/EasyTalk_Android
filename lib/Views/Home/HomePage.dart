import 'package:dacn/Views/WidgetBuiding/ContainerMenuItem.dart';
import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';
import 'package:dacn/Views/WidgetBuiding/PreviewArticle.dart';
import 'package:dacn/Views/WidgetBuiding/PreviewArticleContainer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF81C784), // Xanh lá cây nhạt
                    Color(0xFF64B5F6), // Xanh dương nhạt
                    Color(0xFF4CAF50), // Xanh lá cây đậm
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Bài phát âm đề xuất',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF3E2723)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    const PreviewArticleContainer(
                      articles: [
                        PreviewArticle(
                          id: '1',
                          title: 'Khám Phá Thế Giới Công Nghệ Mới',
                          content: 'Trong thế giới công nghệ ngày nay, chúng ta đang chứng kiến sự phát triển vượt bậc của AI, IoT, và các công nghệ tiên tiến khác. Chúng đang thay đổi cách chúng ta sống, làm việc, và tương tác với nhau.',
                        ),
                        PreviewArticle(
                          id: '2',
                          title: 'Lập Trình Flutter Dễ Dàng Hơn Bạn Nghĩ',
                          content: 'Flutter đã trở thành một công cụ phát triển ứng dụng di động mạnh mẽ. Với khả năng hỗ trợ đa nền tảng, lập trình viên có thể tạo ra những ứng dụng đẹp mắt và mượt mà chỉ với một mã nguồn duy nhất.',
                        ),
                        PreviewArticle(
                          id: '3',
                          title: 'Lợi Ích Của Việc Tập Thể Dục Đều Đặn',
                          content: 'Tập thể dục không chỉ giúp bạn duy trì sức khỏe mà còn là một yếu tố quan trọng để cải thiện tinh thần. Việc tập luyện đều đặn giúp giảm căng thẳng và tăng cường sức đề kháng.',
                        ),
                        PreviewArticle(
                          id: '4',
                          title: 'Cách Chọn Món Ăn Lành Mạnh Mỗi Ngày',
                          content: 'Việc lựa chọn món ăn là rất quan trọng để duy trì sức khỏe. Hãy ưu tiên các thực phẩm tươi sống, nhiều vitamin và khoáng chất để có một cơ thể khỏe mạnh.',
                        ),
                        PreviewArticle(
                          id: '5',
                          title: 'Các Mẹo Tiết Kiệm Thời Gian Khi Làm Việc Từ Xa',
                          content: 'Làm việc từ xa có thể mang lại nhiều lợi ích, nhưng cũng có những thử thách. Để tiết kiệm thời gian và duy trì năng suất, bạn cần có một lịch trình làm việc rõ ràng và không bị xao nhãng.',
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    const Text(
                      'Chảo mửng trở lại',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    const ContainerMenuItem(
                      menuItems: [
                        MenuItem(
                          icon: Icon(Icons.book, color: Colors.yellow,),
                          text: 'Luyện tập ngữ pháp',
                          colorArrow: Colors.yellow,
                        ),
                        MenuItem(
                          icon: Icon(Icons.record_voice_over, color: Colors.red,),
                          text: 'Cải thiện Phát âm',
                          colorArrow: Colors.red,
                        ),
                        MenuItem(
                          icon: Icon(Icons.chat, color: Colors.blue,),
                          text: 'Luyện tập từ vựng',
                          colorArrow: Colors.blue,
                        ),
                        MenuItem(
                          icon: Icon(Icons.mark_chat_read, color: Colors.green,),
                          text: 'Chat box AI',
                          colorArrow: Colors.green,
                        ),
                      ],
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
