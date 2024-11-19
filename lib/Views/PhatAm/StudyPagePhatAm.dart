import 'package:dacn/Views/WidgetBuiding/pronunciation_list.dart';
import 'package:flutter/material.dart';
import 'package:dacn/Service/PronunciationService.dart';
import 'package:dacn/Service/GetDataFromMap.dart';
import 'package:dacn/Model/Pronunciation.dart';
import 'package:dacn/Views/WidgetBuiding/custom_search_appbar.dart';


class StudyPagePhatAm extends StatefulWidget {
  const StudyPagePhatAm({super.key});

  @override
  _StudyPagePhatAmState createState() => _StudyPagePhatAmState();
}

class _StudyPagePhatAmState extends State<StudyPagePhatAm> {
  late Future<List<Pronunciation>> _pronunciationList;

  @override
  void initState() {
    _pronunciationList = fetchPronunciations();
    super.initState();
  }

  Future<List<Pronunciation>> fetchPronunciations() async {
    try {
      final data = await PronunciationService.getPronunciationList();
      List<Pronunciation> pronunciations = GetDataFromMap.getPronunciations(data) ?? [];
      return pronunciations;
    } catch (e) {
      throw Exception('Failed to load pronunciations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSearchAppBar(hintText: 'Tìm kiếm...'),
          PronunciationList(pronunciationList: _pronunciationList),
        ],
      ),
    );
  }
}
