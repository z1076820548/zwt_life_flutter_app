import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:zwt_life_flutter_app/common/dao/UserDao.dart';
import 'package:zwt_life_flutter_app/common/redux/GlobalState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';

//欢迎页
class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;
    //防止多次进入
    Store<GlobalState> store = StoreProvider.of(context);
    CommonUtils.initStatusBarHeight(context);
    new Future.delayed(const Duration(seconds: 2), () {
      NavigatorUtils.goMain(context);
//      UserDao.initUserInfo(store).then((res) {
////        if (res != null && res.result) {
////          //NavigatorUtils.goHome(context);
////        } else {
//          NavigatorUtils.goLogin(context);
////        }
      return true;
//      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return new Container(
          color: Color(GlobalColors.white),
          child: new Center(
            child: new Image(
              image: new AssetImage('static/images/welcome.png'),
            ),
          ),
        );
      },
    );
  }
}
