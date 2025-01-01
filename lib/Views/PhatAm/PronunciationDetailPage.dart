import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dacn/Model/Pronunciation.dart';

class PronunciationDetailPage extends StatelessWidget {
  final Pronunciation pronunciation;

  const PronunciationDetailPage({super.key, required this.pronunciation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              background: pronunciation.images.isNotEmpty
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    base64Decode(pronunciation.images),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              )
                  : Container(color: Colors.grey),
            ),
          ),
          // Nội dung chi tiết
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    pronunciation.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    pronunciation.description,
                    style: const TextStyle(fontSize: 18.0, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
