import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderOverlayer.dart';
import 'package:zwt_life_flutter_app/public.dart';

class ReaderView extends StatelessWidget {
  final Chapter article;
  final int page;
  final double topSafeHeight;

  ReaderView({this.article, this.page, this.topSafeHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.asset('static/images/read_bg.png', fit: BoxFit.cover)),
        ReaderOverlayer(
            article: article, page: page, topSafeHeight: topSafeHeight),
        buildContent(article, page),
      ],
    );
  }

  buildContent(Chapter article, int page) {
    var content = article.stringAtPageIndex(page);
//    content=  StringUtils.formatContent(content);
//    if (content.startsWith('\n')) {
//      content = content.substring(1);
//    }
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(15, topSafeHeight + ReaderUtils.topOffset, 10,
          ScreenUtil2.bottomSafeHeight + ReaderUtils.bottomOffset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title,
              style: TextStyle(fontSize: ScreenUtil2.fixedFontSize(12))),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: content,
                  style: TextStyle(
                      fontSize: ScreenUtil2.fixedFontSize(SettingManager().getReadFontSize().toDouble()),height: SettingManager.getInstance().getLetterHeight(),
                  letterSpacing: SettingManager.getInstance().getLetterSpacing())
              )
            ]),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
