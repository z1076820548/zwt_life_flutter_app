import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class HotSugWidget extends StatelessWidget {
  final List hotWords;
  final ValueChanged<String> goSearchList;

  const HotSugWidget({Key key, this.hotWords, this.goSearchList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          color: GlobalColors.divideLineColor,
          child: Text("热门搜索"),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: hotWords
              .map((i) => GestureDetector(
                    onTap: () => goSearchList(i),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      child: Text(
                        i,
                        style: GlobalConstant.middleText,
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
