import 'package:dacn/Model/MessageChatting.dart';
import 'package:dacn/Service/APICall/AiChatService.dart';
import 'package:dacn/Service/Local/SQFLiteService.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<MessageChatting> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await SQFLiteService.instance.getAllMessages();
    setState(() {
      _messages = messages.reversed.toList();
    });
  }

  Future<void> _sendMessage({
    required String messageText,
    String sender = 'Me',
  }) async {
    if (messageText.trim().isEmpty) return;

    final newMessage = MessageChatting(
      sender: sender,
      message: messageText,
      timestamp: DateTime.now().toIso8601String(),
      textColor: sender == 'Me' ? Colors.white : Colors.black,
      backgroundColor: sender == 'Me' ? Colors.teal.shade300 : Colors.grey.shade100,
    );

    await SQFLiteService.instance.addMessage(newMessage);

    setState(() {
      _messages.insert(0, newMessage);
    });
    _messageController.clear();
  }


  Future<void> _sendToAI(String messageText, {Duration timeoutDuration = const Duration(seconds: 100)}) async {
    // Hiển thị "..." khi đang xử lý phản hồi
    final tempMessage = MessageChatting(
      sender: 'AI',
      message: '...',
      timestamp: DateTime.now().toIso8601String(),
      textColor: Colors.black,
      backgroundColor: Colors.grey.shade300,
    );

    setState(() {
      _messages.insert(0, tempMessage);
    });

    // Gọi API với timeout
    final response = await AiChatService
        .sendingChatAndGetResponse(messageText)
        .timeout(timeoutDuration, onTimeout: () => 'Phản hồi thất bại (timeout)');

    // Cập nhật phản hồi từ AI
    final aiMessage = MessageChatting(
      sender: 'AI',
      message: response,
      timestamp: DateTime.now().toIso8601String(),
      textColor: response == 'Phản hồi thất bại (timeout)' ? Colors.red : Colors.black,
      backgroundColor: response == 'Phản hồi thất bại (timeout)' ? Colors.red.shade100 : Colors.grey.shade100,
    );

    await SQFLiteService.instance.addMessage(aiMessage);

    setState(() {
      _messages[0] = aiMessage; // Thay thế tin nhắn "..." bằng phản hồi thật
    });

  }


  Future<void> _clearMessages() async {
    await SQFLiteService.instance.clearMessages();
    await SQFLiteService.instance.deleteDatabaseFile();
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF0B486B),
                  Color(0xFF4CAF50),
                  Color(0xFFA7DAB5),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: BubblePainter(),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text('Chat With AI To Study'),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _clearMessages,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isSentByMe = message.sender == 'Me';

                      return Align(
                        alignment: isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.backgroundColor, // Màu nền
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
                            message.message,
                            style: TextStyle(
                              color: message.textColor, // Màu chữ
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Nhập tin nhắn',
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
                        onPressed: () async {
                          final text = _messageController.text;
                          await _sendMessage(messageText: text);
                          _sendToAI(text);
                        },
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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

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
