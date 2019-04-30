import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:zwt_life_flutter_app/common/config/Config.dart';
import 'package:zwt_life_flutter_app/common/config/NetConfig.dart';
import 'package:zwt_life_flutter_app/common/local/LocalStorage.dart';
import 'package:zwt_life_flutter_app/common/model/User.dart';
import 'package:zwt_life_flutter_app/common/net/Api.dart';
import 'package:zwt_life_flutter_app/common/redux/UserRedux.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/public.dart';

class UserDao {

  static login(userName, password, store) async {
    String type = userName + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);
    if (Config.DEBUG) {
      print("base64Str login" + base64Str);
    }
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };
    HttpManager.clearAuthorization();
//    ResultData res = await HttpManager.netFetch(Address.getAuthorization(),
//        json.encode(requestParams), null, new Options(method: "post"));

//    if (res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
//      Data resultData = await getUserInfo(null);
//    }
  }

//  //获取用户详细信息
//  static getUserInfo(userName, {needDb = false}) async {
//    UserInfoDbProvider provider = new UserInfoDbProvider();
//    next() async {
//      ResultData res;
//      if (userName == null) {
//        res = await HttpManager.netFetch(
//            Address.getMyUserInfo(), null, null, null);
//      } else {
//        res = await HttpManager.netFetch(
//            Address.getUserInfo(userName), null, null, null);
//      }
//      if (res != null && res.result) {
//        String starred = "---";
//        if (res.data["type"] != "Organization") {
//          Data countRes = await getUserStaredCountNet(res.data["login"]);
//          if (countRes.result) {
//            starred = countRes.data;
//          }
//        }
//        User user = User.fromJson(res.data);
//        user.starred = starred;
//        if (userName == null) {
//          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
//        } else {
//          if (needDb) {
//            provider.insert(userName, json.encode(user.toJson()));
//          }
//        }
//        return new Data(user, true);
//      } else {
//        return new Data(res.data, false);
//      }
//    }
//
//    if (needDb) {
//      User user = await provider.getUserInfo(userName);
//      if (user == null) {
//        return await next();
//      }
//      Data dataResult = new Data(user, true, next: next());
//      return dataResult;
//    }
//    return await next();
//  }

  static clearAll(Store store) async {
    HttpManager.clearAuthorization();
    LocalStorage.remove(Config.USER_INFO);
    store.dispatch(new UpdateUserAction(User.empty()));
  }


  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new Data(user, true);
    } else {
      return new Data(null, false);
    }
  }

  //初始化用户信息
  static initUserInfo(Store store) async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();
    if (res != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
    }

    //读取主题
    String themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if(themeIndex != null && themeIndex.length !=0){
//      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }
    //切换语言
    String localeIndex = await LocalStorage.get(Config.LOCALE);
    if(localeIndex != null && localeIndex.length != 0){
      CommonUtils.changeLocale(store, int.parse(localeIndex));
    }
    return new Data(res.data, (res.result &&(token != null)));
  }


}
