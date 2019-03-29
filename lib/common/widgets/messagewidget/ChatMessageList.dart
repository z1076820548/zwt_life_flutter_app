import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/event/ChatEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageListItem.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ListModel.dart';

//AnimatedList
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
  final List<ChatUser> listData;

  ChatMessageList(
      {Key key,
      @required this.itemBuilder,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.controller,
      this.primary,
      this.physics,
      this.shrinkWrap = false,
      this.padding,
      this.duration = const Duration(milliseconds: 300),
      this.defaultChild,
      @required this.listData})
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
  int _selectedItem;
  int _nextItem;
  ListModel<ChatUser> _list;
  StreamSubscription stream;
  bool _loaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = Code.eventBus.on<ChatEvent>().listen((event) {
      _insert(event.index, event.chatUser);
    });
    _list = ListModel<ChatUser>(
      listKey: _animatedListKey,
      initialItems: widget.listData,
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = _list.length;
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return widget.defaultChild ?? Container();
    }
    // TODO: implement build
    return AnimatedList(
      key: _animatedListKey,
      itemBuilder: _buildItem,
      initialItemCount: _list.length,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return ChatMessageListItem(
      animation: animation,
      chatUser: _list[index],
      selected: _selectedItem == index,
      index: index,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  Widget _buildRemovedItem(
      ChatUser chatUser, BuildContext context, Animation<double> animation) {
    return ChatMessageListItem(
      animation: animation,
      chatUser: chatUser,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert(int index, ChatUser chatUser) {
    _list.insert(index, chatUser);
  }

  // Remove the selected item from the list model.
  void _remove(ChatUser chatUser) {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(chatUser));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
