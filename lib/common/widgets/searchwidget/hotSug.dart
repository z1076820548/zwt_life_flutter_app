import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class HotSugWidget extends StatelessWidget {
  final List<String> hotWords;
  final ValueChanged<String> goSearchList;
  final AsyncCallback tapSwitch;
  int currentIndex;
  final bool isVisible;

  HotSugWidget({
    Key key,
    this.hotWords,
    this.goSearchList,
    this.tapSwitch,
    this.isVisible: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        isVisible
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 50.0,
                    alignment: Alignment.centerLeft,
                    child: Text("大家都在搜"),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 50.0,
                    child: GestureDetector(
                      onTap: tapSwitch,
                      child: Row(
                        children: <Widget>[Icon(Icons.refresh), Text('换一批')],
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: hotWords
                .map((text) => GestureDetector(
                      onTap: () => goSearchList(text),
                      child: Container(
                        decoration: BoxDecoration(
                            color: GlobalColors.randomColor[Random()
                                .nextInt(GlobalColors.randomColor.length - 1)],
                            borderRadius: BorderRadius.circular(5)),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
