import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Nền gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF0B486B), // Xanh đậm (không quá tối)
                  Color(0xFF4CAF50), // Xanh lá trung tính
                  Color(0xFFA7DAB5), // Xanh nhạt (không quá nhạt)
                ],
              ),
            ),
          ),
          // Hiệu ứng bọt biển
          Positioned.fill(
            child: CustomPaint(
              painter: BubblePainter(),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text("Chat"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  itemCount: 10, // Số tin nhắn mẫu
                  itemBuilder: (context, index) {
                    bool isSentByMe = index % 2 == 0;
                    return Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSentByMe
                              ? Colors.teal.shade300
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isSentByMe
                                ? const Radius.circular(12)
                                : const Radius.circular(0),
                            bottomRight: isSentByMe
                                ? const Radius.circular(0)
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          isSentByMe
                              ? "This is a sent message"
                              : "This is a received message",
                          style: TextStyle(
                            color: isSentByMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Nhập tin nhắn",
                          filled: true,
                          fillColor: Colors.teal.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.teal.shade400,
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Vẽ bọt biển
class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final random = [const Offset(100, 300), const Offset(200, 500), const Offset(50, 600)];
    final radii = [50.0, 80.0, 40.0];

    for (int i = 0; i < random.length; i++) {
      canvas.drawCircle(random[i], radii[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
