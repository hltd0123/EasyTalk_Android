import 'package:dacn/Views/WidgetBuiding/ContainerMenuItem.dart';
import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _images = [
    'assets/hutech1.jpg',
    'assets/hutech2.jpg',
    'assets/hutech3.jpg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SizedBox(
                height: 200, // Chiều cao của slider
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          _images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Chào mừng bạn đến với EasyTalk',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Ảnh logo giữa tiêu đề và phần menu bên dưới
              Center(
                child: Image.asset(
                  'assets/eztalk2.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              // Menu chính
              ContainerMenuItem(
                menuItems: [
                  MenuItem(
                    icon: Icon(Icons.book, color: Colors.greenAccent),
                    text: 'Bài học',
                    colorArrow: Colors.greenAccent,
                    menuOptions: [
                      {
                        'icon': Icons.chrome_reader_mode,
                        'text': 'Ngữ pháp',
                        'onClick': () => Navigator.pushNamed(context, '/nguphap')
                      },
                      {
                        'icon': Icons.transcribe_rounded,
                        'text': 'Phát âm',
                        'onClick': () => Navigator.pushNamed(context, '/phatam')
                      },
                      {'icon': Icons.library_books, 'text': 'FlashCard'},
                    ],
                  ),
                  MenuItem(
                    icon: Icon(Icons.menu_book, color: Colors.blue),
                    text: 'Luyện tập',
                    colorArrow: Colors.blue,
                    menuOptions: [
                      {'icon': Icons.chrome_reader_mode, 'text': 'Ngữ pháp'},
                      {
                        'icon': Icons.transcribe_rounded,
                        'text': 'Phát âm',
                        'onClick': () =>
                            Navigator.pushNamed(context, '/phatam', arguments: 1)
                      },
                      {'icon': Icons.type_specimen_rounded, 'text': 'Từ vựng'},
                    ],
                  ),
                  MenuItem(
                    icon: Icon(Icons.chat, color: Colors.yellowAccent),
                    text: 'Chat AI',
                    colorArrow: Colors.blue,
                    onClickWithoutMenuOption: () {
                      Navigator.pushNamed(context, '/aichat');
                    },
                  ),
                  MenuItem(
                    icon: Icon(Icons.layers, color: Colors.deepOrange),
                    text: 'Tra cứu từ điển',
                    colorArrow: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
