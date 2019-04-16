import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';

import 'package:zwt_life_flutter_app/public.dart';

class ReaderCatlog extends StatefulWidget {
  final String bookTitle;
  final List<Chapters> chaptersList;

  ReaderCatlog(this.bookTitle, this.chaptersList);

  @override
  _ReaderCatlogState createState() => _ReaderCatlogState();
}

class _ReaderCatlogState extends State<ReaderCatlog>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  ScrollController _scrollController;

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
      onTap: tap(title),
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
        leading: CupertinoButton(
          child: const Text('取消'),
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text(widget.bookTitle),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: SafeArea(
            child: Center(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(height: .0),
              reverse: true,
              controller: _scrollController,
              itemCount: widget.chaptersList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(widget.chaptersList[index], index);
              }),
        )),
      ),
    );
  }

  tap(String title) {
    switch (title) {
      case '目录':
        break;
    }
  }

  Widget ListItem(Chapters item, int index) {
    return Text(item.title);

  }
}
