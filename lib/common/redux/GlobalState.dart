import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';
import 'package:zwt_life_flutter_app/common/redux/ThemeRedux.dart';
import 'package:zwt_life_flutter_app/common/redux/UserRedux.dart';

class GlobalState {
  //用户信息
  User userInfo;

  //主题数据
  ThemeData themeData;



  //构造方法
  GlobalState({this.userInfo, this.themeData});

}

//创建Reducer
//源码中Reducer是一个方法 typedef State Reducer<State>(State state,dynamic action);
//我们自定义了appReducer用于创建store
GlobalState appReducer(GlobalState state,action){
  return GlobalState(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

  );
}
