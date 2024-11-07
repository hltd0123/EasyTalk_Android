import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final Icon icon;
  final String text;
  final Color colorArrow;
  final List<Map<String, dynamic>>? menuOptions; // menuOptions có thể null

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.colorArrow,
    this.menuOptions, // menuOptions có thể null
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isExpanded = false; // Kiểm tra xem menu có mở hay không

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.menuOptions != null // Kiểm tra nếu có menuOptions
                ? () {
              setState(() {
                _isExpanded = !_isExpanded; // Đảo ngược trạng thái mở/đóng menu
              });
            }
                : null, // Nếu không có menuOptions, không cho phép mở/đóng menu
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 1,
              child: Container(
                padding: const EdgeInsets.all(16.0),
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
                          widget.icon,
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Flexible(
                            child: Text(
                              widget.text,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Chỉ hiển thị icon mũi tên nếu có menuOptions
                    if (widget.menuOptions != null)
                      Icon(
                        _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: widget.colorArrow,
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          // Hiển thị menu nếu có menuOptions và _isExpanded là true
          if (_isExpanded && widget.menuOptions != null && widget.menuOptions!.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF232946),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Column(
                children: widget.menuOptions!.map((option) {
                  IconData iconData = option['icon'];
                  String text = option['text'];

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        // Sử dụng màu của icon trong MenuItem cho icon trong menuOptions
                        Icon(iconData, size: 16, color: widget.icon.color),
                        SizedBox(width: 8),
                        Text(
                          text,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
