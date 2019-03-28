import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/animation/VoicePlayingAnimation.dart';

class ChatMessageListItem extends StatelessWidget {
  final Animation<double> animation;
  final ChatUser chatUser;
  final bool selected;

  ChatMessageListItem(
      {Key key,
      @required this.animation,
      @required this.chatUser,
      this.selected})
      : assert(animation != null),
        assert(chatUser != null),
        assert(selected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: new Row(
          children: chatUser.userId == "1076820548"
              ? getSentMessageLayout()
              : getReceivedMessageLayout(),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TabUserName(chatUser: chatUser),
            new Container(
              child: TabUserChatContent(
                chatUser: chatUser,
              ),
            ),
          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: TabUserIcon(
                chatUser: chatUser,
              )),
        ],
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: TabUserIcon(
                chatUser: chatUser,
              )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabUserName(chatUser: chatUser),
            Container(
              child: TabUserChatContent(
                chatUser: chatUser,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}

//泡沫
class TabUserChatContent extends StatelessWidget {
  StreamSubscription _playerSubscription;
  final ChatUser chatUser;

  TabUserChatContent({Key key, @required this.chatUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chatUser.chatData.voicePath != null &&
        chatUser.chatData.voicePath.length > 0) {
      return GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              chatUser.chatData.timeRecorder,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: -0.4,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            VoicePlayingAnimation(color: GlobalColors.ChatTextColor)
          ],
        ),
      );
    } else if (chatUser.chatData.imageUrl != null &&
        chatUser.chatData.imageUrl.length > 0) {
      if (chatUser.chatData.imageUrl.contains("FILEIMAGE")) {
        String url = chatUser.chatData.imageUrl.replaceAll("FILEIMAGE", "");
        DateTime date = new DateTime.now();
        String tag = "$url" + "$date";
        return GestureDetector(
          onTap: () => gotoImageHudPage(context, FileImage(File(url)), tag),
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(url),
                width: ScreenUtil.getInstance().L(100),
              ),
            ),
          ),
        );
      } else {
        String url = chatUser.chatData.imageUrl;
        DateTime date = new DateTime.now();
        String tag = "$url" + "$date";
        return GestureDetector(
          onTap: () => gotoImageHudPage(context, NetworkImage(url), tag),
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                url,
                width: ScreenUtil.getInstance().L(100),
              ),
            ),
          ),
        );
      }
    } else {
      return FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: GlobalColors.ChatMsgColor,
        onPressed: () => {onTapContent()},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          chatUser.chatData.text,
          style: TextStyle(
            color: Colors.black,
            letterSpacing: -0.4,
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  void onTapContent() {
    if (chatUser.chatData.voicePath != null &&
        chatUser.chatData.voicePath.length > 0) {
      _startPlayer();
    } else if (chatUser.chatData.imageUrl != null &&
        chatUser.chatData.imageUrl.length > 0) {
    } else {}
  }

  //播放录音
  _startPlayer() async {
    //录音
    FlutterSound flutterSound = new FlutterSound();
    if (_playerSubscription != null) {
      _stopPlayer();
    } else {
      String pathPlayer =
          await flutterSound.startPlayer(chatUser.chatData.voicePath);
      print('startPlayer: $pathPlayer');
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {}
      });
    }
  }

  _stopPlayer() async {
    //录音
    FlutterSound flutterSound = new FlutterSound();
    String pathPlayer = await flutterSound.stopPlayer();
    print('stopPlayer: $pathPlayer');
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  gotoImageHudPage(BuildContext context, ImageProvider imagePro, String tag) {
    NavigatorUtils.gotoImageHudPage(context, imagePro, tag);
  }
}

//用户头像
class TabUserIcon extends StatelessWidget {
  final ChatUser chatUser;

  const TabUserIcon({Key key, @required this.chatUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircleAvatar(
      backgroundImage: new NetworkImage(chatUser.userIconUrl),
    );
    return null;
  }
}

//用户名
class TabUserName extends StatelessWidget {
  final ChatUser chatUser;

  const TabUserName({Key key, @required this.chatUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(chatUser.userName,
          style: new TextStyle(
            fontSize: 12.0,
          )),
    );
  }
}
