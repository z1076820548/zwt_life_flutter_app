import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageList.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageListItem.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';

var currentUserEmail;
var _scaffoldContext;

class MessageTalkingPage extends StatefulWidget {
  static final String sName = "MessageTalkingPage";

  @override
  _MessageTalkingPage createState() {
    // TODO: implement createState
    return _MessageTalkingPage();
  }
}

class _MessageTalkingPage extends State<MessageTalkingPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  Animation animationTalk;
  AnimationController controller;
  List<ChatUser> listChat = [];

  getDataList() {
    listChat.add(new ChatUser(
        "1076820548",
        "明识",
        "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        ChatData("12DASDAS", "")));
    listChat.add(new ChatUser(
        "1076820547",
        "DSADAS",
        "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        ChatData("345DASDAS", "")));
    listChat.add(new ChatUser(
        "1076820548",
        "明识",
        "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        ChatData("89ASDAS", "")));
  }

  @override
  void initState() {
    getDataList();
    // TODO: implement initState
    super.initState();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
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
              child: ChatMessageList(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return ChatMessageListItem(
                      animation: animation, chatUser: listChat[index]);
                },
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            Builder(builder: (BuildContext context) {
              _scaffoldContext = context;
              return Container(
                width: 0.0,
                height: 0.0,
              );
            })
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(
                color: Colors.grey[200],
              )))
            : null,
      ),
    );
  }

  void initAnimation() {
    controller = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    animationTalk = new Tween(begin: 1.0, end: 1.5).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {}),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });
  }
}
