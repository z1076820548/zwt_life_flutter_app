import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/common/event/ReaderMenuEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'dart:async';

import 'package:zwt_life_flutter_app/public.dart';

class ReaderCatlog extends StatefulWidget {
  final String bookTitle;
  final List<Chapters> chaptersList;
  final int currentChapterIndex;

  ReaderCatlog(this.bookTitle, this.chaptersList, this.currentChapterIndex);

  @override
  _ReaderCatlogState createState() => _ReaderCatlogState();
}

class _ReaderCatlogState extends State<ReaderCatlog>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  ScrollController _scrollController;
  double itemExtent = 30;

  static List<BoxShadow> get borderShadow {
    return [BoxShadow(color: Color(0x22000000), blurRadius: 8)];
  }

  @override
  initState() {
    super.initState();

    _scrollController = new ScrollController();

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(itemExtent * (widget.currentChapterIndex - 10));
    });
  }

  @override
  void didUpdateWidget(ReaderCatlog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  hide() {
    animationController.reverse();
    Timer(Duration(milliseconds: 200), () {});
  }

  buildTopView(BuildContext context) {
    return Positioned(
      top: -ScreenUtil2.navigationBarHeight * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        decoration:
            BoxDecoration(color: Color(0xFFF5F5F5), boxShadow: borderShadow),
        height: ScreenUtil2.navigationBarHeight,
        padding: EdgeInsets.fromLTRB(5, ScreenUtil2.topSafeHeight, 5, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Icon(Icons.headset),
            ),
            Container(
              width: 44,
              child: Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: -(ScreenUtil2.bottomSafeHeight + 110) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), boxShadow: borderShadow),
            padding: EdgeInsets.only(bottom: ScreenUtil2.bottomSafeHeight),
            child: Column(
              children: <Widget>[
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildBottomItem('目录', 'static/images/read_icon_catalog.png'),
        buildBottomItem('亮度', 'static/images/read_icon_brightness.png'),
        buildBottomItem('字体', 'static/images/read_icon_font.png'),
        buildBottomItem('设置', 'static/images/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Image.asset(icon),
            SizedBox(height: 5),
            Text(title,
                style: TextStyle(
                    fontSize: ScreenUtil2.fixedFontSize(12),
                    color: Color(0xFF333333))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: GlobalColors.appbarColor,
        leading: CupertinoButton(
          child: const Text('取消'),
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(widget.bookTitle),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton(
              child: const Text('顶'),
              padding: EdgeInsets.zero,
              onPressed: () {
                toTop();
              },
            ),
            CupertinoButton(
              child: const Text('底'),
              padding: EdgeInsets.zero,
              onPressed: () {
                toBottom();
              },
            )
          ],
        ),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: Center(
          child: CupertinoScrollbar(
            child: ListView.builder(
                reverse: false,
                itemExtent: itemExtent,
                controller: _scrollController,
                itemCount: widget.chaptersList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(widget.chaptersList[index], index);
                }),
          ),
        ),
      ),
    );
  }

  Widget ListItem(Chapters item, int index) {
    bool currentBool = (widget.currentChapterIndex == index);
    String title = item.title;
    if (title.length > 17) {
      title = title.substring(0, 17) + '......';
    }
    return Material(
      child: Ink(
        child: InkWell(
          onTap: () {
            tap(index);
          },
          child: Container(
//        padding: EdgeInsets.all(15),
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      currentBool
                          ? Icon(
                              Icons.location_on,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.bookmark_border,
                              size: 15,
                            ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      currentBool
                          ? Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            )
                          : Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 14),
                            ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Divider(
                    height: 0.0,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  tap(index) {
    index = widget.chaptersList.length - (index) - 1;
    Navigator.pop(context);
    Code.eventBus.fire(new ReaderMenuEvent(ReaderMenuType.catlog, index));
  }

  void toTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  void toBottom() {
    _scrollController.animateTo(itemExtent * (widget.chaptersList.length - 10),
        duration: Duration(seconds: 1), curve: Curves.ease);
  }
}
