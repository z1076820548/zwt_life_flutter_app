import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/page/HomePage.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/MyCupertinoDialog.dart';

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
  var appBarTitles = ['商品', '消息', '购物车', '我的'];
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
  Icon getTabIcon(int curIndex) {
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
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: Colors.deepOrangeAccent));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: Colors.black38));
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
      [Icon(Icons.home), Icon(Icons.home)],
      [Icon(Icons.message), Icon(Icons.message)],
      [Icon(Icons.shopping_cart), Icon(Icons.shopping_cart)],
      [Icon(Icons.person_outline), Icon(Icons.person_outline)]
    ];

    _bodys = [
      new HomePage(),
      new HomePage(),
      new HomePage(),
      new HomePage(),
//      new ShopPage(),
//      new MsgPage(),
//      new MyPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640)..init(context);
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
      bottomNavigationBar: BottomNavigationBar(
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
        fixedColor: Colors.deepOrangeAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
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
