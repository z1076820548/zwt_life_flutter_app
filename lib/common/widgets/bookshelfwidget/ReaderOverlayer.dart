import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provide/provide.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/BatteryView.dart';
import 'package:zwt_life_flutter_app/public.dart';

class ReaderOverlayer extends StatelessWidget {
  final Chapter article;
  final int page;
  final double topSafeHeight;
   final String bookId;
  ReaderOverlayer({this.article, this.page, this.topSafeHeight, this.bookId});

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(
          15,  5+ topSafeHeight, 15, 10 + ScreenUtil2.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      Text(article.title,style: TextStyle(fontSize: ScreenUtil2.fixedFontSize(12))),
    Expanded(child: Container()),
          Row(
            children: <Widget>[
              BatteryView(),
              SizedBox(width: 10),
              Text(time, style: TextStyle(fontSize: ScreenUtil2.fixedFontSize(11))),
              Expanded(child: Container(
                alignment: Alignment.center,
                child: Provide<DownloadStatusEvent>(
                  builder: (context,child,downloadStatusEvent)=>
                  (downloadStatusEvent.type == DownloadEventType.loading
                      && downloadStatusEvent.bookId == bookId) ? Text(
                      '缓存 '+'${downloadStatusEvent.current }'+'/'+'${downloadStatusEvent.end}'
                      ,style: TextStyle(fontSize: ScreenUtil2.fixedFontSize(11))):Text(''),
                ),
              )),
              Text('第${page + 1}'+'/'+'${article.pageCount}'+'页',
                  style: TextStyle(fontSize: ScreenUtil2.fixedFontSize(11))),
            ],
          ),
        ],
      ),
    );
  }
}
