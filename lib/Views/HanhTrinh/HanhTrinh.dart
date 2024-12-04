import 'package:dacn/Service/APICall/JourneyService.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:flutter/material.dart';
import 'CuaVaChang.dart';

class HanhTrinh extends StatelessWidget {
  const HanhTrinh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Hành Trình Học Tập',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: JourneyService.getJourneyList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          final journeyList = GetDataFromMap.getJourneyList(data)!;

          return Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: journeyList.length,
                  itemBuilder: (context, index) {
                    final item = journeyList[index];
                    return Column(
                      children: [
                        _buildSquareTile(
                            title: item.title,
                            progress: item.progressPercentage.toDouble(),
                            context: context,
                            journeyId: item.id),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSquareTile(
      { required String title,
        required double progress,
        required BuildContext context,
        required String journeyId}) {

    return GestureDetector(
      onTap: () async {
        var data = await JourneyService.getJourneyOnJourneyId(journeyId);
        var journey = GetDataFromMap.getJourney(data)!;
        var userProcess = GetDataFromMap.getUserProgress(data)!;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CuaVaChang(
              gateList: journey.gates,
              userProgress: userProcess,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity, // Khung chiếm toàn bộ chiều rộng
        margin: const EdgeInsets.symmetric(vertical: 8), // Khoảng cách giữa các Card
        padding: const EdgeInsets.all(16), // Padding bên trong Card
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền trắng
          borderRadius: BorderRadius.circular(16), // Bo góc đẹp hơn
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15), // Màu bóng nhẹ
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4), // Đổ bóng mềm
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Cho phép cột tự điều chỉnh chiều cao
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tiêu đề
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20, // Kích thước font vừa phải
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Thanh tiến trình nằm giữa
            LinearProgressIndicator(
              value: progress / 100, // Tính tiến độ từ phần trăm
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 16),
            // Phần trăm hoàn thành hiển thị bên dưới thanh
            Text(
              '${progress.toStringAsFixed(0)}% hoàn thành',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
