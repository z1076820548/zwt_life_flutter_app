import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/dao/DaoResult.dart';
import 'package:zwt_life_flutter_app/common/local/LocalStorage.dart';
import 'package:zwt_life_flutter_app/common/local/SharedPreferencesKeys.dart';
import 'package:zwt_life_flutter_app/common/model/search_history.dart';
import 'package:zwt_life_flutter_app/common/utils/util/shared_preferences.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/refresh/PullLoadWidget.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/search/SearchInput.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

  @override
  void initState() {
    super.initState();
    initSearchHistory();
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) {}, (value) {}, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearchInput(context),
      ),
      body: Column(
        children: <Widget>[
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
  bool get needHeader => false;

  @override
  requestLoadMore() async {
    return new DataResult(addStr, true);
  }

  @override
  requestRefresh() async {

    return new DataResult(str, true);
  }

  _renderEventItem(int index) {
    return Container(
      height: 70.0,
      child: Card(
        child: Center(
          child: Text(
            pullLoadWidgetControl.dataList[index],
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

}
