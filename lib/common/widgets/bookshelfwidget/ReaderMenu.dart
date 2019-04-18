import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zwt_life_flutter_app/common/event/ReaderMenuEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderCatlog.dart';
import 'dart:async';

import 'package:zwt_life_flutter_app/public.dart';

class ReaderMenu extends StatefulWidget {
  final VoidCallback onTap;
  final String book;
  final List<Chapters> chaptersList;
  final int currentIndex;

  ReaderMenu({this.onTap, this.book, this.chaptersList, this.currentIndex});

  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  int fontSize = SettingManager().getReadFontSize();
  double fontHeight = SettingManager().getLetterHeight();
  double progressValue = 0.5;
  bool showSetting = false;

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
    showSetting = false;
  }

  buildTopView(BuildContext context) {
    return Positioned(
      top: -ScreenUtil2.navigationBarHeight * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        decoration:
            BoxDecoration(color: Color(0xFFF5F5F5), boxShadow: borderShadow),
        height: ScreenUtil2.navigationBarHeight - 20,
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
            padding: EdgeInsets.only(bottom: (ScreenUtil2.bottomSafeHeight)),
            child: Column(
              children: <Widget>[
                showSetting ? buildSetting() : Container(),
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
        buildBottomItem('夜间', Icons.brightness_2),
        buildBottomItem('目录', Icons.view_list),
        buildBottomItem('缓存', Icons.file_download),
        buildBottomItem('设置', Icons.settings),
      ],
    );
  }

  buildBottomItem(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Listener(
        onPointerDown: (PointerDownEvent event) => tap(title),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(height: 0),
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
      case '设置':
        setState(() {
          showSetting = !showSetting;
        });
        break;
    }
  }

  buildCatlog() {
    var chap = widget.chaptersList.reversed.toList();
    int currentChapterIndex = chap.length - widget.currentIndex - 1;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ReaderCatlog(widget.book, chap, currentChapterIndex),
          fullscreenDialog: true,
        ));
  }

  buildSetting() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        children: <Widget>[
          //调节亮度
          buildProgressView(),
          //调节字体尺寸
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  child: Ink(
                    child: InkWell(
                      onTap: () => fontTap(--fontSize),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.black, width: 2),
                          // 边色与边宽度
                          borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                        ),
                        child: Text(
                          "Aa-",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Material(
                  child: Ink(
                    child: InkWell(
                      onTap: () => fontTap(++fontSize),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.black, width: 2),
                          // 边色与边宽度
                          borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                        ),
                        child: Text(
                          "Aa+",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          //调节行距
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    fontHeightTap(1.0);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: new Border.all(
                          color:
                              (fontHeight == 1.0) ? Colors.red : Colors.black,
                          width: 2),
                      // 边色与边宽度
                      borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'static/images/fontheight2.png',
                          height: 20,
                          color:
                              (fontHeight == 1.0) ? Colors.red : Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                GestureDetector(
                  onTap: () {
                    fontHeightTap(1.25);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: new Border.all(
                          color:
                              (fontHeight == 1.25) ? Colors.red : Colors.black,
                          width: 2),
                      // 边色与边宽度
                      borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'static/images/fontheight3.png',
                          height: 20,
                          color:
                              (fontHeight == 1.25) ? Colors.red : Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                GestureDetector(
                  onTap: () {
                    fontHeightTap(1.4);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: new Border.all(
                          color:
                              (fontHeight == 1.4) ? Colors.red : Colors.black,
                          width: 2),
                      // 边色与边宽度
                      borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'static/images/fontheight4.png',
                          height: 20,
                          color:
                              (fontHeight == 1.4) ? Colors.red : Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildProgressView() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.brightness_medium,
              size: 20,
            ),
          ),
          Expanded(
            child: Slider(
              value: progressValue,
              onChanged: (double value) {
                setState(() {
                  progressValue = value;
                });
              },
              onChangeEnd: (double value) {},
              activeColor: GlobalColors.themeColor,
              inactiveColor: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.wb_sunny,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  fontTap(int fontSize) {
    print("修改字体大小为" + fontSize.toString());
    Code.eventBus.fire(new ReaderMenuEvent(ReaderMenuType.fontsize, fontSize));
  }

  void fontHeightTap(double height) {
    print("修改字体高度为" + height.toString());
    setState(() {
      fontHeight = height;
    });
    Code.eventBus.fire(new ReaderMenuEvent(ReaderMenuType.rowSpacing, height));
  }
}
