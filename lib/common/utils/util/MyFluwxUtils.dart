import 'package:fluwx/fluwx.dart' as fluwx;

class MyFluwxUtils {
  static final String TAG = "MyFluwxUtils: ";
  static final String WX_APPID = "wxe8316119b19a6731";

  static login() async {
//    bool agreeLogin = false;
    await fluwx.register(appId: WX_APPID);
    await fluwx.sendAuth(
        scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
//    await fluwx.responseFromAuth.listen((onData) {
//      //微信回调
//      switch (onData.errCode) {
//        case 0:
//          print(TAG + "用户同意");
////          agreeLogin = true;
//          break;
//        case -4:
//          print(TAG + "用户拒绝授权");
//          break;
//        case -2:
//          print(TAG + "用户取消");
//          break;
//      }
//    });
//    return agreeLogin;
  }
}
