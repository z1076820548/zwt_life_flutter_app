import 'dart:async';
import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:zwt_life_flutter_app/common/dao/UserDao.dart';
import 'package:zwt_life_flutter_app/common/redux/GlobalState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';
import 'package:zwt_life_flutter_app/public.dart';

//欢迎页
class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Timer _timer;
  bool hadInit = false;
  int sTime = 4;

  List<String> messageList = [
    '劳于读书，逸于作文。 —— 程端礼',
    '读书使人心明眼亮。 —— 伏尔泰',
    '为乐趣而读书。 —— 毛姆',
    '读书何所求?将以通事理。 —— 张维屏',
    '读书之法，在循序而渐进，熟读而精思。 —— 朱熹',
    '读书时要深思多问。只读而不想，就可能人云亦云，沦为书本的奴隶；或者走马看花，所获甚微。 —— 王梓坤',
    '外物之味，久则可厌，读书之味，愈久愈深。 —— 程颐',
    '读书忌死读，死读钻牛角。 —— 叶圣陶',
    '读书百遍，其义自现。 —— 三国志',
    '读书要玩味。 —— 程颢',
    '不去读书就没有真正的教养，同时也不可能有什么鉴别力。 —— 赫尔岑',
    '我们可以由读书搜集知识，但必须利用思考把糠和麦子分开。 —— 富斯德',
    '纸上得来终觉浅，绝知此事要躬行。 —— 陆游',
    '读书使人成为完善的人。 —— 培根',
    '读活书，活读书，读书活。 —— 郭沫若',
    '读书谓已多，抚事知不足。 —— 王安石'
        '读书不知味，不如束高阁；蠢鱼尔何如，终日食糟粕。 —— 袁牧',
    '读书对于智慧，就像体操对于身体一样。 —— 爱迪生',
    '不加思考地滥读或无休止地读书，所读过的东西无法刻骨铭心，其大部分终将消失殆尽。 —— 叔本华',
    '任何时候，我也不会满足，越是多读书，就越是深刻地感到不满足，越感到自己知识贫乏。科学是奥妙无穷的。 —— 马克思',
    '鸟欲高飞先振翅，人求上进先读书。 —— 李苦禅',
    '养心莫若寡欲;至乐无如读书。 —— 郑成功',
    '读书对于我来说是驱散生活中的不愉快的最好手段。没有一种苦恼是读书所不能驱散的。 —— 孟德斯鸠',
    '“先生不应该专教书，他的责任是教人做人；学生不应该专读书，他的责任是学习人生之道。”。 —— 陶行知',
    '经验丰富的人读书用两只眼睛，一只眼睛看到纸面上的话，另一只眼睛看到纸的背面。 —— 歌德',
    '读书勿求多，岁月既积，卷帙自富。 —— 冯班',
    '三更灯火五更鸣，正是男儿读书时，黑发不知勤学早，白发方悔读书迟。 —— 颜真卿',
    '为中华之崛起而读书。 —— 周恩来',
    '我读书总是以少为贵，从不贪多。不怕读得少，只怕记不牢。 —— 徐特立',
    '或作或辍，一曝十寒，则虽读书百年，吾未见其可也。 —— 吴梦祥',
    '读书而不思考，等于吃饭而不消化。 —— 波尔克',
    '立身以立学为先，立学以读书为本。 —— 朱熹',
    '人家不必论富贵，惟有读书声最佳。 —— 唐寅'
  ];
  var msg;

  @override
  void dispose() {
    _timer.cancel();
    myBanner.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    msg = messageList[Random().nextInt(messageList.length - 1)];
    // TODO: implement initState
    super.initState();
    var male = SettingManager().getUserChooseSex();
    var m = male == 'male' ? MobileAdGender.male : MobileAdGender.female;
    FirebaseAdMob.instance.initialize(appId: AdmobId.AppId);

    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', '今日追书'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: m,
      // or MobileAdGender.female, MobileAdGender.unknown
//      testDevices: <String>[], // Android emulators are considered test devices
    );
    myBanner = BannerAd(
      adUnitId: AdmobId.BannerId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 10,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    myInterstitial = InterstitialAd(
      adUnitId: AdmobId.InterstitialId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.top,
        anchorOffset: 0.0,
      );
    _timer = Timer.periodic(Duration(seconds: 4), (time) async {
      if (sTime == 1) {
        timeOver();
      } else {
        setState(() {
          --sTime;
        });
      }
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Material(
          child: new Container(
            color: Color(GlobalColors.white),
            child: new Center(
              child: Stack(
                children: <Widget>[
                  Image(
                    image: new AssetImage('static/images/welcome.jpeg'),
                  ),
                  Positioned(
                    top: 25,
                    right: 25,
                    child: GestureDetector(
                      onTap: () {
                        timeOver();
                      },
                      child: Container(
                        color: Colors.white70,
                        child: Text("跳过广告 $sTime" + "s"),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 160,
                      right: 10,
                      width: 210,
                      child: Container(
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              msg,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void timeOver() {
    NavigatorUtils.goMain(context);
  }
}
