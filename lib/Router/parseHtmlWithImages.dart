import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

String parseHtmlWithImages(String htmlString) {
  final document = html_parser.parse(htmlString);
  String textOutput = '';

  for (var element in document.body!.nodes) {
    if (element is Element && element.localName == 'img') {
      // Thêm link ảnh vào kết quả
      textOutput += "[Image: ${element.attributes['src']}]\n";
    } else if (element is Text) {
      // Thêm nội dung văn bản
      textOutput += element.text + '\n';
    }
  }
  return textOutput;
}
