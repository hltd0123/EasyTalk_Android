import 'dart:convert';
import 'package:dacn/Views/PhatAm/PronunciationDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:dacn/Service/Local/GetDataFromMap.dart';
import 'package:dacn/Model/Pronunciation.dart';

class PronunciationStudyList extends StatelessWidget {
  final Future<List<Pronunciation>> pronunciationList;

  const PronunciationStudyList({super.key, required this.pronunciationList});

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
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: ListTile(
                      title: Text(
                        pronunciation.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        pronunciation.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: pronunciation.images.isNotEmpty
                          ? Image.memory(base64Decode(pronunciation.images))
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PronunciationDetailPage(
                              pronunciation: pronunciation,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: pronunciations.length,
            ),
          );
        }
      },
    );
  }
}
