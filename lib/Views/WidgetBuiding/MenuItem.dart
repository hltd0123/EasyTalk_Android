import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color colorArrow;
  final VoidCallback? onTap;

  const MenuItem({super.key,
    required this.icon,
    required this.text,
    required this.colorArrow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF232946),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Row(
                    children: [
                      icon,
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      Flexible(
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                          overflow: TextOverflow.ellipsis,  // Đảm bảo rằng text sẽ bị cắt với "..."
                          maxLines: 1,  // Giới hạn 1 dòng
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: colorArrow),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
