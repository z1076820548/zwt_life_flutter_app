import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';


class ChatMessageList extends StatefulWidget {
  final AnimatedListItemBuilder itemBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final Duration duration;
  final Widget defaultChild;

  const ChatMessageList({Key key,
    @required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.duration = const Duration(milliseconds: 300),
    this.defaultChild})
      : super(key: key);

  @override
  ChatMessageListState createState() {
    // TODO: implement createState
    return ChatMessageListState();
  }
}

class ChatMessageListState extends State<ChatMessageList> {
  final GlobalKey<AnimatedListState> _animatedListKey =
  GlobalKey<AnimatedListState>();
  bool _loaded = true;
  List<ChatUser> listChat;

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return widget.defaultChild ?? Container();
    }
    // TODO: implement build
    return AnimatedList(
      key: _animatedListKey,
      itemBuilder: widget.itemBuilder,
      initialItemCount: 3,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
    );
  }

//  Widget _buildItem(BuildContext context, int index,
//      Animation<double> animation) {
//    return widget.itemBuilder(context, ,animation, index);
//  }
}
