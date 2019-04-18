import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BookShelfPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/FindBookPage.dart';
import 'package:zwt_life_flutter_app/page/homepage/HomePage.dart';
import 'package:zwt_life_flutter_app/page/messagepage/MessageContactsPage.dart';
import 'package:zwt_life_flutter_app/page/messagepage/MessageTalkingPage.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/MyCupertinoDialog.dart';
import 'package:zwt_life_flutter_app/public.dart';
class MainPage extends StatefulWidget {
  static final String sName = "main";

  //单机提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => MyCupertinoDialog(
              content: CommonUtils.getLocale(context).app_back_tip,
              confirmPress: () {
                Navigator.of(context).pop(true);
              },
            ));
  }

  @override
  _MainPageState createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  var appBarTitles = ['书架', '找书', '购物车', '我的'];
  var tabImages;

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _selectedIndex) {
      return new Text(appBarTitles[curIndex]);
    } else {
      return new Text(appBarTitles[curIndex]);
    }
  }

  /*
   * 存储的四个页面，和Fragment一样
   */
  var _bodys;

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [getTabImage('static/images/bookshelf1.png'), getTabImage('static/images/bookshelf2.png')],
      [getTabImage('static/images/searchblack.png'), getTabImage('static/images/searchblue.png')],
      [getTabImage('static/images/bookshelf1.png'), getTabImage('static/images/bookshelf2.png')],
      [getTabImage('static/images/bookshelf1.png'), getTabImage('static/images/bookshelf2.png')],
//      [Icon(Icons.message), Icon(Icons.message)],
//      [Icon(Icons.shopping_cart), Icon(Icons.shopping_cart)],
//      [Icon(Icons.person_outline), Icon(Icons.person_outline)]
    ];

    _bodys = [
       BookShelfPage(),
       FindBookPage(),
       HomePage(),
       HomePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: ScreenUtil.designWidth, height: ScreenUtil.designHeight)
      ..init(context);
    initData();
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text("dasdasd"),
//        actions: <Widget>[
//          //导航栏右侧菜单
//          IconButton(icon: Icon(Icons.share), onPressed: () {}),
//        ],
//      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: GlobalColors.themeColor,
        // 底部导航
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: getTabIcon(2), title: getTabTitle(2)),
          new BottomNavigationBarItem(
              icon: getTabIcon(3), title: getTabTitle(3)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

      ),
      body: _bodys[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
