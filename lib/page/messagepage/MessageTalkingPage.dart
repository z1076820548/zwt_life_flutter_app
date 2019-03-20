import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwt_life_flutter_app/common/event/ChatEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
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
  final ScrollController _scrollController = new ScrollController();
  FocusNode _contentFocusNode = FocusNode();
  bool _isComposingMessage = false;
  Animation animationTalk;
  AnimationController controller;
  List<ChatUser> listChat = [];
  EventBus eventBus = new EventBus();

  getDataList() {
    listChat.add(new ChatUser(
        userId: "1076820548",
        userName: "明识",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766000,
        chatData: ChatData(text: "你是？？？", imageUrl: "")));
    listChat.add(new ChatUser(
        userId: "1076820547",
        userName: "明识2",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766058,
        chatData: ChatData(text: "我叫明识2", imageUrl: "")));
    listChat.add(new ChatUser(
        userId: "1076820548",
        userName: "明识",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766111,
        chatData: ChatData(text: "哦哦，我叫明识，萨瓦迪卡", imageUrl: "")));
    listChat.sort((a, b) {
      if (a.time > b.time) {
        return 1;
      } else {
        return -1;
      }
    });
  }

  @override
  void initState() {
    getDataList();
    // TODO: implement initState
    super.initState();
    initAnimation();
    initScroll();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.5,
          title: Text(
            "老杨",
            style: TextStyle(
                fontSize: GlobalConstant.middleTextWhiteSize,
                fontWeight: FontWeight.w600),
          ),
//          backgroundColor: GlobalColors.ChatThemeColor,
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
        color: GlobalColors.ChatBgColor,
        child: Column(
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                onPanDown: (DragDownDetails e) {
                  //隐藏输入框
                  hideKey();
                },
                child: Scrollbar(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      //return true; //放开此行注释后，进度条将失效
                    },
                    child: ChatMessageList(
                      listData: listChat,
                      controller: _scrollController,
                      reverse: false,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        return ChatMessageListItem(
                            animation: animation, chatUser: listChat[index]);
                      },
                    ),
                  ),
                ),
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
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: Theme.of(context).disabledColor,
        ),
        child: new Container(
          color: GlobalColors.ChatBgColor,
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                    ),
                    onPressed: () async {}),
              ),
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: new TextField(
                    controller: _textEditingController,
                    onChanged: (String messageText) {
                      setState(() {
                        _isComposingMessage = messageText.length > 0;
                      });
                    },
                    onSubmitted: _textMessageSubmitted,
                    decoration: new InputDecoration(
                        filled: true,
                        fillColor: GlobalColors.ChatMsgColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 4),
                        hintText: "",
                        border: OutlineInputBorder()),
                  ),
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
      icon: _isComposingMessage
          ? Icon(
              Icons.send,
              color: Theme.of(context).accentColor,
            )
          : Icon(Icons.add_circle_outline),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();
    hideKey();
    setState(() {
      listChat.add(new ChatUser(
          userId: "1076820548",
          userName: "明识",
          userIconUrl:
              "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
          time: 1552876766000,
          chatData: ChatData(text: text, imageUrl: "")));
      _isComposingMessage = false;
    });
    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendMessage({String messageText, String imageUrl}) {
    Code.eventBus.fire(new ChatEvent(
        index: listChat.length,
        chatUser: ChatUser(
            userId: "1076820548",
            userName: "明识",
            userIconUrl:
                "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
            time: 1552876766000,
            chatData: ChatData(text: messageText, imageUrl: ""))));
  }

  void initScroll() {
    _scrollController.addListener(() {});
  }

  void hideKey() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
