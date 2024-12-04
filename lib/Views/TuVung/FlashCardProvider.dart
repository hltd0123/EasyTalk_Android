import 'package:dacn/Model/FlashCard.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FlashCardProvider with ChangeNotifier {
  List<FlashCard> _flashCards;
  int _currentIndex = 0;
  bool _showExample = false;

  FlashCardProvider(this._flashCards);

  FlashCard get currentFlashCard => _flashCards[_currentIndex];
  int get currentIndex => _currentIndex;
  bool get showExample => _showExample;

  int get flashCardCount => _flashCards.length;

  void nextFlashCard() {
    if (_currentIndex < _flashCards.length - 1) {
      _currentIndex++;
      _showExample = false; // Reset trạng thái ví dụ khi chuyển flash card
      notifyListeners();
    }
  }

  void previousFlashCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _showExample = false; // Reset trạng thái ví dụ khi chuyển flash card
      notifyListeners();
    }
  }

  void removeCurrentFlashCard() {
    if (_flashCards.isNotEmpty) {
      _flashCards.removeAt(_currentIndex);
      if (_currentIndex >= _flashCards.length) {
        _currentIndex = max(0, _flashCards.length - 1); // Đảm bảo không vượt quá giới hạn
      }
      _showExample = false; // Reset trạng thái ví dụ khi xóa flash card
      notifyListeners();
    }
  }

  void shuffleFlashCards() {
    _flashCards.shuffle();
    _currentIndex = 0; // Đặt lại chỉ mục sau khi shuffle
    _showExample = false; // Reset trạng thái ví dụ
    notifyListeners();
  }

  void toggleExample() {
    _showExample = !_showExample;
    notifyListeners();
  }
}
