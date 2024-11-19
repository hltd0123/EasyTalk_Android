import 'package:flutter/material.dart';

class CustomSearchAppBar extends StatelessWidget {
  final String hintText;

  const CustomSearchAppBar({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.transparent,
      expandedHeight: 80.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            color: Colors.white.withOpacity(0.9),
            child: Row(
              children: [
                const SizedBox(width: 8.0),
                Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(fontSize: 18.0),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
