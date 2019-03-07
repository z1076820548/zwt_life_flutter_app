import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/model/Event.dart';
import 'package:zwt_life_flutter_app/common/model/TrendingRepoModel.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';
import 'package:zwt_life_flutter_app/common/redux/EventRedux.dart';
import 'package:zwt_life_flutter_app/common/redux/LocaleRedux.dart';
import 'package:zwt_life_flutter_app/common/redux/ThemeRedux.dart';
import 'package:zwt_life_flutter_app/common/redux/TrendReducer.dart';
import 'package:zwt_life_flutter_app/common/redux/UserRedux.dart';

class GlobalState {
  //用户信息
  User userInfo;
  ///用户接受到的事件列表
  List<Event> eventList = new List();

  ///用户接受到的事件列表
  List<TrendingRepoModel> trendList = new List();

  //主题数据
  ThemeData themeData;

  //语言
  Locale locale;

  //当前手机平台默认语言
  Locale platformLocale;

  //构造方法
  GlobalState({this.userInfo, this.eventList, this.trendList, this.themeData, this.locale});

}

//创建Reducer
//源码中Reducer是一个方法 typedef State Reducer<State>(State state,dynamic action);
//我们自定义了appReducer用于创建store
GlobalState appReducer(GlobalState state,action){
  return GlobalState(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过 EventReducer 将 GSYState 内的 eventList 和 action 关联在一起
    eventList: EventReducer(state.eventList, action),

    ///通过 TrendReducer 将 GSYState 内的 trendList 和 action 关联在一起
    trendList: TrendReducer(state.trendList, action),

    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

    ///通过 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
    locale: LocaleReducer(state.locale, action),
  );
}
