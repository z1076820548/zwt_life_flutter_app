import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/BatteryView.dart';
import 'package:zwt_life_flutter_app/public.dart';

class ReaderOverlayer extends StatelessWidget {
  final Chapter article;
  final int page;
  final double topSafeHeight;

  ReaderOverlayer({this.article, this.page, this.topSafeHeight});

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(
          15, 10 + topSafeHeight, 15, 10 + ScreenUtil2.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Expanded(child: Container()),
          Row(
            children: <Widget>[
              BatteryView(),
              SizedBox(width: 10),
              Text(time, style: TextStyle(fontSize: ScreenUtil().setSp(11))),
              Expanded(child: Container()),
              Text('第${page + 1}页',
                  style: TextStyle(fontSize: ScreenUtil().setSp(11))),
            ],
          ),
        ],
      ),
    );
  }
}
