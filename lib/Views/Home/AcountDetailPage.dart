import 'package:dacn/Views/WidgetBuiding/CardItem.dart';
import 'package:flutter/material.dart';
import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF81C784), // Xanh lá cây nhạt
                Color(0xFF64B5F6), // Xanh dương nhạt
                Color(0xFF4CAF50), // Xanh lá cây đậm
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column( // Thay Row bằng Column để các widget con có thể sắp xếp theo chiều dọc
            children: [
              CardItem(
                title: 'Char',
                imageUrl: 'https://www.shutterstock.com/shutterstock/photos/2506648107/display_1500/stock-photo-cluster-of-ripe-red-apples-hanging-from-a-tree-branch-2506648107.jpg',
                points: '300',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
