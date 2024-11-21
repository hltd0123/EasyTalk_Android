import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  // Danh sách lời nhắc
  final List<Map<String, String>> _reminders = [];
  TimeOfDay _selectedTime = TimeOfDay.now(); // Mặc định là thời gian hiện tại
  String _repeatOption = 'Không'; // Mặc định không lặp lại

  void _addReminder() {
    // Hàm thêm lời nhắc mới
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = ''; // Tiêu đề
        String content = ''; // Nội dung
        return AlertDialog(
          title: const Text('Tạo lời nhắc'),
          content: SingleChildScrollView(  // Để có thể cuộn khi có nhiều nội dung
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề cho trường Tiêu đề
                const Text(
                  'Tiêu đề:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                // Khung nhập liệu Tiêu đề
                TextField(
                  onChanged: (value) {
                    title = value; // Cập nhật Tiêu đề
                  },
                  decoration: const InputDecoration(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                // Tiêu đề cho trường Nội dung
                const Text(
                  'Nội dung:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                // Thu nhỏ khung nhập nội dung
                Container(
                  height: 80, // Chiều cao của khung nhập nội dung
                  child: TextField(
                    onChanged: (value) {
                      content = value; // Cập nhật Nội dung
                    },
                    decoration: const InputDecoration(),
                    style: const TextStyle(fontSize: 18),
                    maxLines: 4, // Số dòng tối đa
                    minLines: 2, // Số dòng tối thiểu
                  ),
                ),
                const SizedBox(height: 20),
                // Tiêu đề cho trường Chọn thời gian
                const Text(
                  'Chọn thời gian:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                // Center widget để căn giữa khung chọn thời gian
                Center(
                  child: Container(
                    height: 150, // Chiều cao của picker
                    child: TimePickerSpinner(
                      time: DateTime.now(),
                      is24HourMode: true,
                      onTimeChange: (time) {
                        setState(() {
                          _selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
                        });
                      },
                      spacing: 40,
                      itemHeight: 50, // Thu nhỏ chiều cao item
                      isForce2Digits: true,
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Thêm khoảng cách giữa chọn thời gian và chọn số lần lặp lại
                // Tiêu đề cho trường Lặp lại
                const Text(
                  'Số lần lặp lại:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                // Khung chọn số lần lặp lại
                DropdownButton<String>(
                  value: _repeatOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _repeatOption = newValue!;
                    });
                  },
                  items: <String>['Không', 'Mỗi ngày', 'Mỗi tuần', 'Mỗi tháng']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                // Hiển thị lựa chọn đã chọn
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  setState(() {
                    _reminders.add({
                      'front': title,
                      'back': content,
                      'time': _selectedTime.format(context),
                      'repeat': _repeatOption, // Lưu lựa chọn lặp lại
                    });
                  });
                  Navigator.of(context).pop(); // Đóng hộp thoại sau khi thêm lời nhắc
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
          'Lời nhắc',
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
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _reminders.isEmpty
                    ? 'Bạn chưa tạo lời nhắc nào'
                    : 'Danh sách các lời nhắc',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _reminders.isEmpty
                  ? Center(
                child: GestureDetector(
                  onTap: _addReminder,
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
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(reminder['front']!),
                      subtitle: Text(
                          "${reminder['back']} - ${reminder['time']} - Lặp lại: ${reminder['repeat']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _reminders.removeAt(index); // Xóa lời nhắc
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
        onPressed: _addReminder,
        child: const Icon(Icons.add),
      ),
    );
  }
}
