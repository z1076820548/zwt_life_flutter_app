import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwt_life_flutter_app/common/event/ChatEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/ToastUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageList.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageListItem.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';
import 'package:zwt_life_flutter_app/common/utils/util/soundutils.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/MyFlatButton.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/MyOutLineButton.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/MyRaisedButton.dart';

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
  //输入框控制
  final TextEditingController _textEditingController =
      new TextEditingController();

  //发送完消息 需要下拉到最底部
  final ScrollController _scrollController = new ScrollController();
  bool _isComposingMessage = false;
  bool _isMicroPhone = false;
  List<ChatUser> listChat = [];
  EventBus eventBus = new EventBus();
  FocusNode nodeOne = FocusNode();
  bool isStartRecoder = false;

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
        return -1;
      } else {
        return 1;
      }
    });
  }

  @override
  void initState() {
    getDataList();
    initScroll();

    // TODO: implement initState
    super.initState();
  }

  initSound() {}

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
                onTap: () => hideKey(),
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
                      reverse: true,
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

  //返回到底部的动画
  void bottomAnimation() {
    _scrollController.jumpTo(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  Widget _getDefultTextFile() {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !_isMicroPhone,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => _startRecorder(),
            onPointerUp: (PointerUpEvent event) => _stopRecorder(),
            child: MyOutlineButton(
              color: GlobalColors.ChatMsgColor,
              splashColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              text: isStartRecoder ? "松开 结束" : "按住 说话",
            ),
          ),
        ),
        Offstage(
          offstage: _isMicroPhone,
          child: TextField(
            focusNode: nodeOne,
            maxLines: null,
            textInputAction: TextInputAction.send,
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                hintText: "",
                border: OutlineInputBorder()),
          ),
        )
      ],
    );
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
                child: getDefaultMicButton(),
              ),
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _getDefultTextFile(),
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
              size: 30,
            )
          : Icon(
              Icons.add_circle_outline,
              size: 30.0,
            ),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultMicButton() {
    return _isMicroPhone
        ? IconButton(
            icon: new Icon(
              Icons.keyboard,
              size: 30.0,
            ),
            onPressed: () async {
              setState(() {
                _isMicroPhone = false;
                showKey();
              });
            })
        : IconButton(
            icon: new Icon(
              Icons.mic,
              size: 30.0,
            ),
            onPressed: () async {
              setState(() {
                _isMicroPhone = true;
                hideKey();
              });
            });
  }

//  SoundUtils.getInstance().startRecorder(uri: "1.mp4");

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();
    if (text.length < 1) {
      return;
    }
//    hideKey();
    setState(() {
      listChat.add(new ChatUser(
          userId: "1076820548",
          userName: "明识",
          userIconUrl:
              "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
          time: 1552876766000,
          chatData: ChatData(text: text, imageUrl: "")));

      _isComposingMessage = false;
      _sendMessage(messageText: text, imageUrl: null);
      bottomAnimation();
    });
  }

  void _sendMessage({String messageText, String imageUrl}) {
    Code.eventBus.fire(new ChatEvent(
        index: 0,
        chatUser: ChatUser(
            userId: "1076820548",
            userName: "明识",
            userIconUrl:
                "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
            time: 1552876766000,
            chatData: ChatData(text: messageText, imageUrl: ""))));
  }

  void _startRecorder()async {
    setState(() {
      isStartRecoder = true;
    });
    String uri = await SoundUtils.getInstance().getPath("46545654564/sound.mp4");
    File file = new File(uri);
    bool exists = await file.exists();
    if (!exists) {
      await file.delete();
      SoundUtils.getInstance().startRecorder(uri: uri);
      return;
    }
  }

  void _stopRecorder() {
    setState(() {
      isStartRecoder = false;
    });
//    SoundUtils.getInstance().stopRecorder();
  }

  void initScroll() {
    _scrollController.addListener(() {});
  }

  void hideKey() {
    setState(() {
      if (nodeOne.hasFocus) {
        nodeOne.unfocus();
      }
    });
  }

  void showKey() {
    setState(() {
      FocusScope.of(context).requestFocus(nodeOne);
    });
  }
}
