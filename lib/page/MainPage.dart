import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BookShelfPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/FindBookPage.dart';
import 'package:zwt_life_flutter_app/page/homepage/HomePage.dart';
import 'package:zwt_life_flutter_app/page/messagepage/MessageContactsPage.dart';
import 'package:zwt_life_flutter_app/page/messagepage/MessageTalkingPage.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/MyCupertinoDialog.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

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
  var appBarTitles = ['书架', '找书'];
  var tabImages;
  StreamSubscription _stream;
  static List<DownloadEvent> downloadEventList = [];
  bool isBusy = false; // 当前是否有下载任务在进行
  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage1(path) {
    return new Image.asset(
      path,
      width: 20.0,
      height: 20.0,
      color: Colors.black,
    );
  }

  Image getTabImage2(path) {
    return new Image.asset(
      path,
      width: 20.0,
      height: 20.0,
      color: GlobalColors.themeColor,
    );
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
      [
        getTabImage1('static/images/bookshelf1.png'),
        getTabImage2('static/images/bookshelf2.png')
      ],
      [
        getTabImage1('static/images/searchblack.png'),
        getTabImage2('static/images/ic_find_in_page.png')
      ],
//      [
//        getTabImage1('static/images/bookshelf1.png'),
//        getTabImage2('static/images/bookshelf2.png')
//      ],
//      [
//        getTabImage1('static/images/bookshelf1.png'),
//        getTabImage2('static/images/bookshelf2.png')
//      ],
//      [Icon(Icons.message), Icon(Icons.message)],
//      [Icon(Icons.shopping_cart), Icon(Icons.shopping_cart)],
//      [Icon(Icons.person_outline), Icon(Icons.person_outline)]
    ];

    _bodys = [
      BookShelfPage(),
      FindBookPage(),
//      HomePage(),
//      HomePage(),
    ];

    //缓存监听
    _stream = Code.eventBus.on<DownloadEvent>().listen((event) {
      BackgroundFetch.configure(
          BackgroundFetchConfig(
              minimumFetchInterval: 1,
              stopOnTerminate: false,
              enableHeadless: true), () async {
        for (int i = downloadEventList.length - 1; i >= 0; i--) {
          if (downloadEventList[i].downloadBean.bookId ==
              event.downloadBean.bookId) {
            print('任务已存在');
            break;
          } else {
            if (i == 0) {
              downloadEventList.add(event);
              var connectivityResult =
                  await (new Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.none) {
                print('网络异常，取消下载');
              } else {
                check();
              }
              break;
            }
          }
        }
      });
    });
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
      //用IOS的比较美观
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.grey[100],
        activeColor: GlobalColors.themeColor,
        // 底部导航
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
//          new BottomNavigationBarItem(
//              icon: getTabIcon(2), title: getTabTitle(2)),
//          new BottomNavigationBarItem(
//              icon: getTabIcon(3), title: getTabTitle(3)),
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

  void check() async {
    if (!isBusy && downloadEventList.length > 0) {
      for (int i = 0; i < downloadEventList.length; i++) {
        startDownload(downloadEventList[i]);
      }
    }
  }

  void startDownload(DownloadEvent downloadEventList) async {
    List<Chapters> list = downloadEventList.downloadBean.list;
    String bookId = downloadEventList.downloadBean.bookId;
    int start = downloadEventList.downloadBean.start; // 起始章节
    int end = downloadEventList.downloadBean.end; // 结束章节

    for (int i = start; i <= end && i <= list.length; i++) {
      if (downloadEventList.type == DownloadEventType.cancel ||
          downloadEventList.type == DownloadEventType.remove ||
          downloadEventList.type == DownloadEventType.pause) {
        break;
      }
      if (downloadEventList.type != DownloadEventType.finish) {
        // 章节文件不存在,则下载，否则跳过
        String contents = await DownloadManager.getChapter(bookId, i);
        if (contents.trim().length > 0) {
        } else {
          Data data = await dioGetChapterBody(list[i].link, list[i].title);
          Chapter chapter = data.data;
          await DownloadManager.saveChapter(bookId, i, chapter.body);
          if (i == end) {
            downloadEventList.type = DownloadEventType.finish;
          }
        }
      }
    }
  }
}
