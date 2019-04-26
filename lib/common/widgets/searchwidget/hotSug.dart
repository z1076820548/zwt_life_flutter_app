import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class HotSugWidget extends StatefulWidget {
  final List<String> hotWords;
  final ValueChanged<String> goSearchList;

  const HotSugWidget({Key key, this.hotWords, this.goSearchList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotSugWidgetState();
  }
}

class _HotSugWidgetState extends State<HotSugWidget> {
  int currentIndex;

  List<String> listHot = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData(widget.hotWords.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: Text("大家都在搜"),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 100),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    initData(currentIndex);
                  },
                  child: Row(
                    children: <Widget>[Icon(Icons.refresh), Text('换一批')],
                  ),
                ),
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: listHot
              .map((text) => GestureDetector(
                    onTap: () => widget.goSearchList(text),
                    child: Container(
                      decoration: BoxDecoration(
                          color: GlobalColors.randomColor[Random()
                              .nextInt(GlobalColors.randomColor.length - 1)],
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      child: Text(
                        text,
                        style: GlobalConstant.middleText,
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  void initData(int index) {
    if (widget.hotWords.length == 0) {
    } else {
      int tagSize = 10;
      currentIndex = index;
      List<String> list = [];
      for (int i = 0; i < tagSize; i++) {
        --currentIndex;
        if (currentIndex < 0) {
          currentIndex = widget.hotWords.length - 1;
        }
        list.add(widget.hotWords[currentIndex]);
      }
      setState(() {
        listHot = list;
      });
    }
  }
}
