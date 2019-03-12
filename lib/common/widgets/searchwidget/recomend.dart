import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class RecomendListWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onItemTap;

  const RecomendListWidget({Key key, this.items, this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            onTap: () => onItemTap(items[i]),
            child: Container(
              height: 42,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                items[i],
                style: TextStyle(fontSize: 15),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int i) {
          return Container(
            height: 1,
            color: GlobalColors.searchRecomendDividerColor,
          );
        },
        itemCount: items.length);
  }
}
