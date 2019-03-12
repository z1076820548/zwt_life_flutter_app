import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class SearchListTopBarTitleWidget extends StatelessWidget {
  final String keyworld;

  const SearchListTopBarTitleWidget({Key key, this.keyworld}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil.searchTxtFieldHeight,
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(right: 30),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: GlobalColors.divideLineColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: GestureDetector(
        onTap: () => {Navigator.pop(context)},
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: GlobalColors.floorTitleColor,
              size: 20,
            ),
            Text(
              keyworld,
              style: GlobalConstant.smallText,
            )
          ],
        ),
      ),
    );
  }
}
