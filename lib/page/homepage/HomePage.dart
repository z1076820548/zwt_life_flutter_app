import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/dao/DaoResult.dart';
import 'package:zwt_life_flutter_app/common/data/HomeData.dart';
import 'package:zwt_life_flutter_app/common/local/SharedPreferencesKeys.dart';
import 'package:zwt_life_flutter_app/common/model/kingkong.dart';
import 'package:zwt_life_flutter_app/common/model/search_history.dart';
import 'package:zwt_life_flutter_app/common/utils/util/shared_preferences.dart';
import 'package:zwt_life_flutter_app/common/widgets/homewidget/HomeTopBar.dart';
import 'package:zwt_life_flutter_app/common/widgets/homewidget/banner.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/refresh/PullLoadWidget.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/refresh/MyListState.dart';

class HomePage extends StatefulWidget {
  static final String sName = "Home";

  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomePage>,
        MyListState<HomePage> {
  SearchHistoryList searchHistoryList;
  SpUtil sp;
  var hotSearchTag = [
    "网曝杨紫邓伦热恋 | 元宵节诗词 | 身份证异地能补办吗",
    "两限房是什么意思 | 公务员可以考研吗 | 一元等于多少日元",
    "喻恩泰喊话王景春 | 云南结婚吹唢呐视频 | 汉服下裙穿法"
  ];

  initSearchHistory() async {
    sp = await SpUtil.getInstance();
    String json = sp.getString(SharedPreferencesKeys.searchHistory);
    print("json $json");
    searchHistoryList = SearchHistoryList.fromJSON(json);
  }

  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List dataList1 = [];

  _processPinweidata() {
    dataList1 = [];
    var rags = homedata['data']['rags'];
    rags.forEach((rag) {
      if (rag['editorName'] == 'pinwei_home_floor') {
        dataList1.add({
          'editorName': 'pinwei_home_floor_title',
          'title': rag['title'],
          'url': rag['more']
        });
      }
      (rag['rags'] as List).forEach((dynamic r) {
        if (r['title'] == '') {
          r['title'] = rag['title'];
        }
        dataList1.add(r);
      });
    });
    //  print(dataList1);
  }

  @override
  void initState() {
    super.initState();
    initSearchHistory();
    _processPinweidata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          HomeTopBar(),
          Expanded(
            child: PullLoadWidget(
              pullLoadWidgetControl,
              (BuildContext context, int index) => _renderEventItem(index),
              handleRefresh,
              onLoadMore,
              refreshKey: refreshIndicatorKey,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement isRefreshFirst
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => true;

  @override
  requestLoadMore() async {
    return new DataResult(addStr, true);
  }

  @override
  requestRefresh() async {
    return new DataResult(str, true);
  }

  _renderEventItem(int index) {
    if (index == 0) {
      return _headeeWidget();
    } else {
      return Container(
        height: 70.0,
        child: Card(
          child: Center(
            child: Text(
              pullLoadWidgetControl.dataList[index - 1],
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      );
    }
  }

  _headeeWidget() {
    List<String> banners = <String>[
      'https://img.alicdn.com/simba/img/TB18voJihYaK1RjSZFnSuu80pXa.jpg_q50.jpg'
          'http://img.alicdn.com/imgextra/i3/115/O1CN01PsvX9s1Cii2Pvi3WM_!!115-0-luban.jpg',
      'https://gw.alicdn.com/imgextra/i3/43/O1CN01ZPUEId1CBjWPLKzea_!!43-0-lubanu.jpg',
      'https://gw.alicdn.com/imgextra/i2/41/O1CN01yCNeuw1CAojHBeUyC_!!41-0-lubanu.jpg'
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SwipperBanner(
          banners: banners,
        ),
        SwipperGrid(data: KingKongList.fromJson(dataList1[1]['items'])),
      ],
    );
  }
}
