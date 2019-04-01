//登录页
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:zwt_life_flutter_app/common/config/Config.dart';
import 'package:zwt_life_flutter_app/common/dao/UserDao.dart';
import 'package:zwt_life_flutter_app/common/local/LocalStorage.dart';
import 'package:zwt_life_flutter_app/common/local/SharedPreferencesKeys.dart';
import 'package:zwt_life_flutter_app/common/model/search_history.dart';
import 'package:zwt_life_flutter_app/common/redux/GlobalState.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/MyRaisedButton.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/MyTextField.dart';
import 'package:zwt_life_flutter_app/public.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";
  SearchHistoryList searchHistoryList;
  @override
  _LoginPageState createState() {
    // TODO: implement createState
    return new _LoginPageState();
  }
}


class _LoginPageState extends State<LoginPage> {
  var _userName = "";
  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  _LoginPageState() : super();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initParams();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<GlobalState>(builder: (context, store) {
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: new Container(
            decoration: new BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage(GlobalIcons.LOGIN_BACKGROUND_ICON),
                fit: BoxFit.cover,
              ),
            ),
            //color: Theme.of(context).primaryColor,
            child: new Center(
              //防止overFlow的现象
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          image: AssetImage(GlobalIcons.DEFAULT_USER_ICON),
                          width: 90.0,
                          height: 90.0,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        MyTextField(
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          hintText: CommonUtils.getLocale(context)
                              .login_username_hint_text,
                          iconData: GlobalIcons.LOGIN_USER,
                          onChanged: (String value) {
                            _userName = value;
                          },
                          controller: userController,
                        ),
                        new Padding(padding: new EdgeInsets.all(10.0)),
                        new MyTextField(
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          hintText: CommonUtils.getLocale(context)
                              .login_password_hint_text,
                          iconData: GlobalIcons.LOGIN_PW,
                          obscureText: true,
                          onChanged: (String value) {
                            _password = value;
                          },
                          controller: pwController,
                        ),
                        new Padding(padding: new EdgeInsets.all(10.0)),
                        new MyRaisedButton(
                          text: CommonUtils.getLocale(context).login_text,
                          color: Colors.greenAccent[400],
                          textColor: Color(GlobalColors.textWhite),
                          onPress: () {
//                            if (_userName.isEmpty || _password.isEmpty) {
//                              return;
//                            }
//                            CommonUtils.showLoadingDialog(context);
//                            UserDao.login(
//                                    _userName.trim(), _password.trim(), store)
//                                .then((res) {
//                              print("11111111111111111111");
//                              if (res != null && res.result) {
//                                Navigator.pop(context);
//                                print("2222222222222222222222222");
//                                new Future.delayed(const Duration(seconds: 1),
//                                    () {
//                                  NavigatorUtils.goHome(context);
//                                  return true;
//                                });
//                              }
//                              return true;
//                            });
                           // CommonUtils.showLoadingDialog(context);
                            NavigatorUtils.goMain(context);
//                            MyFluwxUtils.login();
//                            MyFluwxUtils.login().then((agreeLogin) {
//                              if (agreeLogin) {
//                               // Navigator.pop(context);
//                                NavigatorUtils.goHome(context);
//                              } else {
//                                ToastUtils.showShortToast(
//                                    CommonUtils.getLocale(context).app_cancel);
//                              }
//                            });
                          },
                        ),
                        new Padding(padding: EdgeInsets.all(30.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }
}
