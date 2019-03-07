import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/localization/DefaultLocalizations.dart';

//多语言委托
class GlobalLocalizationsDelegate
    extends LocalizationsDelegate<GlobalLocalizations> {
  @override
  bool isSupported(Locale locale) {
    //支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  //根据locale,创建一个对象用于提供当前locale下的文本显示
  @override
  Future<GlobalLocalizations> load(Locale locale) {
    return new SynchronousFuture<GlobalLocalizations>(
        new GlobalLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GlobalLocalizations> old) {
    return false;
  }

  GlobalLocalizationsDelegate();

  //全局静态的代理
  static GlobalLocalizationsDelegate delegate =
      new GlobalLocalizationsDelegate();
}
