import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';

class ChatMessageListItem extends StatelessWidget {
  final Animation animation;
  final ChatUser chatUser;

  ChatMessageListItem({this.animation, this.chatUser});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
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
            new Text(chatUser.userName,
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: chatUser.chatData.ImageUrl != null
                  ? new Image.network(
                      chatUser.chatData.ImageUrl,
                      width: 250.0,
                    )
                  : new Text(chatUser.chatData.text),
            ),
          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(chatUser.userIconUrl),
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
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(chatUser.userIconUrl),
              )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(chatUser.userName,
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: chatUser.chatData.ImageUrl != null
                  ? new Image.network(
                      chatUser.chatData.ImageUrl,
                      width: 250.0,
                    )
                  : new Text(chatUser.chatData.text),
            ),
          ],
        ),
      ),
    ];
  }
}
