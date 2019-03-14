import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class MessageTalkingPage extends StatefulWidget {
  static final String sName = "MessageTalkingPage";

  @override
  _MessageTalkingPage createState() {
    // TODO: implement createState
    return _MessageTalkingPage();
  }
}

class _MessageTalkingPage extends State<MessageTalkingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(
            "老杨",
            style: TextStyle(
                fontSize: GlobalConstant.middleTextWhiteSize,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: GlobalColors.ChatThemeColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {},
            )
          ],
        ),
        preferredSize: Size.fromHeight(ScreenUtil.designTopBarHeight),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FirebaseAnimatedList,
            ),
          ],
        ),
      ),
    );
  }
}
