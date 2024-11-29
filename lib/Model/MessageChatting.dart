

import 'package:flutter/material.dart';

class MessageChatting {
  final int? id;
  final String sender;
  final String message;
  final String timestamp;
  final Color textColor; // Màu chữ
  final Color backgroundColor; // Màu nền

  MessageChatting({
    this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    this.textColor = Colors.black, // Mặc định là màu đen
    this.backgroundColor = Colors.white, // Mặc định là màu trắng
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'sender': sender,
    'message': message,
    'timestamp': timestamp,
    'textColor': textColor.value, // Chuyển màu thành giá trị int
    'backgroundColor': backgroundColor.value, // Chuyển màu thành giá trị int
  };

  factory MessageChatting.fromJson(Map<String, dynamic> json) => MessageChatting(
    id: json['id'],
    sender: json['sender'],
    message: json['message'],
    timestamp: json['timestamp'],
    textColor: Color(json['textColor']), // Chuyển int thành Color
    backgroundColor: Color(json['backgroundColor']), // Chuyển int thành Color
  );
}
