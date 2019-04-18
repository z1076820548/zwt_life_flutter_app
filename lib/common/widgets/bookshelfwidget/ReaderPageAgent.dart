import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/public.dart';

class ReaderPageAgent {
  static List<Map<String, int>> getPageOffsets(
      String content, double height, double width, double fontSize) {
//    //行高
//    double spanHeight = SettingManager.getInstance().getLetterHeight();
//    //间距
//    double spanSpacing = SettingManager.getInstance().getLetterHeight();
//
//    double fontHeight = (fontSize + (spanHeight - 1) * fontSize * 2);
//    double fontWidth = (width / 17);
//    //几列
//    int maxColumn = width ~/ fontWidth;
//    //几行
//    int maxLines = (height - 20) ~/ fontHeight - 1;
//
//    double realHeight = maxLines * fontHeight;
//
//    //一页的字数为
//    int fontLength = maxColumn * maxLines;
//
//    print("111111 " +
//        height.toString() +
//        " " +
//        fontSize.toString() +
//        " " +
//        maxLines.toString() +
//        " " +
//        fontLength.toString()
//    +" "+fontWidth.toString());
//    String tempStr = content;
//    List<Map<String, int>> pageConfig = [];
//    int start = 0;
//    Map<String, int> offset = {};
////    TextPainter textPainter =
////        TextPainter(textDirection: TextDirection.ltr, maxLines: maxLines);
////    textPainter.text = TextSpan(
////        text: tempStr,
////        style: TextStyle(
////            fontSize: fontSize,
////            height: spanHeight,
////            letterSpacing: spanSpacing));
////    textPainter.layout(maxWidth: width, minWidth: width);
////      var end =
////          textPainter.getPositionForOffset(Offset(width, realHeight)).offset;
////      if (start + length > tempStr.length) {
////        break;
////      }
//    for (int start = 0; start < (content.length - fontLength) ;
//        start = start + fontLength ) {
//      offset['start'] = start;
//      var end;
////      if (content.length - start < fontLength) {
////        end = content.length - 1;
////      } else {
////        end = start + fontLength;
////      }
//      tempStr = content.substring(start, end);
//      print('11111' + tempStr);
//      offset['end'] = end;
//      pageConfig.add(offset);
//      break;
//    }
//    return pageConfig;

    String tempStr = content;
    List<Map<String, int>> pageConfig = [];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(text: tempStr, style: TextStyle(fontSize: fontSize,
          height: SettingManager.getInstance().getLetterHeight(),
          letterSpacing:
          SettingManager.getInstance().getLetterSpacing()));
      textPainter.layout(maxWidth: width);
      var end = textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfig.add(offset);
    }
    return pageConfig;
  }
}
