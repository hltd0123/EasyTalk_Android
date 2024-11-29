import 'package:flutter/material.dart';

class MainPagePhatAmProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();  // Thông báo cho tất cả các widget nghe được khi trạng thái thay đổi
  }
}