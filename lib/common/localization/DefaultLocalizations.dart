import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStringBase.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStringEn.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStringZh.dart';

//自定义多语言实现

class GlobalLocalizations {
  final Locale locale;

  GlobalLocalizations(this.locale);

  //根据不同locale/languageCode 加载不同语言对应
  //GlobalStringEn和GlobalStringZh都继承了GlobalStringBase
  static Map<String, GlobalStringBase> _localizedValues = {
    'en': new GlobalStringEn(),
    'zh': new GlobalStringZh(),
  };

  GlobalStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过localizations加载当前的GloblaLocalizations
  //获取对应的GlobalStringBase
  static GlobalLocalizations of(BuildContext context){
    return Localizations.of(context,GlobalLocalizations);
  }
}