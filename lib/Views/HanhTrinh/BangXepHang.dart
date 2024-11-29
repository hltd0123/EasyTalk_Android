import 'package:flutter/material.dart';

class BangXepHang extends StatelessWidget {
  const BangXepHang({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách người dùng và điểm của họ
    final List<Map<String, dynamic>> rankings = [
      {'name': 'Người Dùng 1', 'score': 95},
      {'name': 'Người Dùng 2', 'score': 88},
      {'name': 'Người Dùng 3', 'score': 92},
      {'name': 'Người Dùng 4', 'score': 80},
      {'name': 'Người Dùng 5', 'score': 85},
      {'name': 'Người Dùng 6', 'score': 78},
      {'name': 'Người Dùng 7', 'score': 89},
      {'name': 'Người Dùng 8', 'score': 91},
      {'name': 'Người Dùng 9', 'score': 93},
      {'name': 'Người Dùng 10', 'score': 87},
    ];

    // Sắp xếp danh sách theo điểm từ cao đến thấp
    rankings.sort((a, b) => b['score'].compareTo(a['score']));

    // Lấy kích thước màn hình để tính toán kích thước font hợp lý
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;  // Tính kích thước chữ bằng 5% của độ rộng màn hình

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bảng Xếp Hạng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity, // Tăng độ rộng để khung rộng toàn bộ màn hình
          decoration: BoxDecoration(
            color: Colors.white, // Màu nền bên trong khung
            borderRadius: BorderRadius.circular(12), // Bo góc khung
            border: Border.all(color: Colors.black, width: 3), // Viền đen in đậm
          ),
          child: Column(
            children: [
              // Row để căn 3 text "Top", "Tên Người Dùng", "Điểm"
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Căn Top bên trái
                    Text(
                      'Top',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                      ),
                    ),
                    const SizedBox(width: 15), // Khoảng cách giữa "Top" và các text khác
                    // Tên Người Dùng căn giữa
                    Expanded(
                      child: Center(
                        child: Text(
                          'Tên Người Dùng',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black, // Màu của đường phân cách
                      thickness: 2, // Độ dày của đường phân cách
                      width: 20, // Khoảng cách từ text đến đường phân cách
                    ),
                    // Điểm căn lề phải
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Điểm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2), // Đường phân cách giữa tiêu đề và bảng dưới
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Hiển thị tối đa 10 người dùng
                  itemBuilder: (context, index) {
                    final ranking = rankings[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          // Top căn lề trái
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                            ),
                          ),
                          const SizedBox(width: 15), // Khoảng cách giữa "Top" và các phần tử khác
                          // Tên Người Dùng căn giữa
                          Expanded(
                            child: Center(
                              child: Text(
                                '${ranking['name']}',
                                style: TextStyle(
                                  fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                                ),
                              ),
                            ),
                          ),
                          // Điểm căn lề phải
                          Text(
                            '${ranking['score']}',
                            style: TextStyle(
                              fontSize: fontSize,  // Sử dụng fontSize tính toán từ kích thước màn hình
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
