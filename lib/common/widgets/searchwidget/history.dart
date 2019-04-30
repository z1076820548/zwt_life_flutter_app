import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class HistoryListWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onItemTap;
  final AsyncCallback tapDelete;

  const HistoryListWidget({Key key, this.items, this.onItemTap, this.tapDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 50.0,
              alignment: Alignment.centerLeft,
              child: Text("历史搜索"),
            ),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(right: 20),
              height: 50.0,
              child: GestureDetector(
                onTap: tapDelete,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Wrap(
          children: items
              .map((text) => GestureDetector(
                    onTap: () => onItemTap(text),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: items.length == 1 ? ScreenUtil.screenWidth:(ScreenUtil.screenWidth / 2),
                      padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
