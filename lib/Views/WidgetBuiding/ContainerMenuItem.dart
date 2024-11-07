import 'package:dacn/Views/WidgetBuiding/MenuItem.dart';
import 'package:flutter/material.dart';

class ContainerMenuItem extends StatelessWidget {
  final List<MenuItem> menuItems;

  const ContainerMenuItem({super.key, required this.menuItems,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị danh sách MenuItem
          ...menuItems,
        ],
      ),
    );
  }
}

