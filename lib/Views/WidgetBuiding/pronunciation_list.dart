import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dacn/Service/GetDataFromMap.dart';
import 'package:dacn/Model/Pronunciation.dart';
import 'package:dacn/Service/PronunciationService.dart';

class PronunciationList extends StatelessWidget {
  final Future<List<Pronunciation>> pronunciationList;

  const PronunciationList({Key? key, required this.pronunciationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pronunciation>>(
      future: pronunciationList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverFillRemaining(
            child: const Center(child: Text('No pronunciations found')),
          );
        } else {
          final pronunciations = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final pronunciation = pronunciations[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3, // Max chiều cao là 30% chiều cao màn hình
                    ),
                    child: ListTile(
                      title: Text(
                        pronunciation.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Hiển thị "..." khi văn bản tràn
                      ),
                      subtitle: Text(
                        pronunciation.description,
                        maxLines: 2, // Giới hạn 2 dòng
                        overflow: TextOverflow.ellipsis, // Hiển thị "..." khi văn bản tràn
                      ),
                      leading: pronunciation.images.isNotEmpty
                          ? Image.memory(base64Decode(pronunciation.images))
                          : null,
                    ),
                  ),
                );
              },
              childCount: pronunciations.length, // Dynamically set the childCount based on the data
            ),
          );
        }
      },
    );
  }
}
