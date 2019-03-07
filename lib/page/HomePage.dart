import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/local/LocalStorage.dart';
import 'package:zwt_life_flutter_app/common/local/SharedPreferencesKeys.dart';
import 'package:zwt_life_flutter_app/common/model/search_history.dart';
import 'package:zwt_life_flutter_app/common/utils/util/shared_preferences.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/listviewrefresh/custom/HomeListRefresh.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/search/SearchInput.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  static final String sName = "Home";

  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
          child: HomeListRefresh(),
        )
        ],
      ),
    );
  }
}
