import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderCatlog.dart';
import 'dart:async';

import 'package:zwt_life_flutter_app/public.dart';

class ReaderMenu extends StatefulWidget {
  final VoidCallback onTap;
  final String book;
  final List<Chapters> chaptersList;

  ReaderMenu({this.onTap, this.book, this.chaptersList});

  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  double progressValue;

  static List<BoxShadow> get borderShadow {
    return [BoxShadow(color: Color(0x22000000), blurRadius: 8)];
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void didUpdateWidget(ReaderMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  hide() async {
    animationController.reverse();
    Timer(Duration(milliseconds: 0), () {
      this.widget.onTap();
    });
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
        buildBottomItem('目录', Icon(Icons.view_list)),
        buildBottomItem('亮度', Icon(Icons.brightness_4)),
        buildBottomItem('字体', Icon(Icons.font_download)),
        buildBottomItem('设置', Icon(Icons.settings)),
      ],
    );
  }

  buildBottomItem(String title, Icon icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Listener(
        onPointerDown: (PointerDownEvent event) => tap(title),
        child: Column(
          children: <Widget>[
            icon,
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
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (_) {
              hide();
            },
            child: Container(color: Colors.transparent),
          ),
          buildTopView(context),
          buildBottomView(),
        ],
      ),
    );
  }

  tap(String title) async {
    switch (title) {
      case '目录':
        await hide();
        buildCatlog();
        break;
    }
  }

  buildCatlog() {
    var chap = widget.chaptersList.reversed;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ReaderCatlog(widget.book, chap),
          fullscreenDialog: true,
        ));
  }
}
