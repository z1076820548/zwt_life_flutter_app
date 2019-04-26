import 'package:flutter/material.dart';

//颜色
class GlobalColors {
  static const Color themeColor = Colors.green;
  static const Color appbarColor = Color(0xFFEEEEEE);
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;

  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

//聊天背景颜色
  static const Color ChatThemeColor = Color.fromRGBO(242, 242, 242, 1.0);
  static const Color ChatBgColor = Color.fromRGBO(229, 229, 229, 0.3);
  static const Color ChatMsgColor = Color.fromRGBO(254, 255, 254, 1.0);
  static const Color ChatTextColor = Colors.black87;

//  static const Color themeColor = Color.fromRGBO(132, 95, 63, 1.0);
  static const Color floorTitleColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color searchBarBgColor = Color.fromRGBO(240, 240, 240, 1.0);
  static const Color searchBarTxtColor = Color(0xFFCDCDCD);
  static const Color divideLineColor = Color.fromRGBO(245, 245, 245, 1.0);
  static const Color categoryDefaultColor = Color(0xFF666666);
  static const Color priceColor = Color.fromRGBO(182, 9, 9, 1.0);
  static const Color pinweicorverSubtitleColor =
      Color.fromRGBO(153, 153, 153, 1.0);
  static const Color pinweicorverBtTxtColor = Color(0xFFFFFFFF);
  static const Color tabtxtColor = Color.fromRGBO(88, 88, 88, 1.0);
  static const Color cartDisableColor = Color.fromRGBO(221, 221, 221, 1.0);
  static const Color cartItemChangenumBtColor =
      Color.fromRGBO(153, 153, 153, 1.0);
  static const Color cartItemCountTxtColor = Color.fromRGBO(102, 102, 102, 1.0);
  static const Color cartBottomBgColor = Color(0xFFFFFFFF);
  static const Color goPayBtTxtColor = Color(0xFFFFFFFF);
  static const Color searchAppBarBgColor = Color(0xFFFFFFFF);

  static const Color bottomBarbgColor = Color.fromRGBO(250, 250, 250, 1.0);

  static const Color searchRecomendDividerColor = Color(0xFFdedede);

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
  static int random = 200;
  static List<Color> randomColor = [
    Colors.orange[200],
    Colors.red[200],
    Colors.pink[200],
    Colors.purple[200],
    Colors.deepPurple[200],
    Colors.indigo[200],
    Colors.blue[200],
    Colors.lightBlue[200],
    Colors.cyan[200],
    Colors.teal[200],
    Colors.green[200],
    Colors.lightGreen[200],
    Colors.lime[200],
    Colors.yellow[200],
    Colors.amber[200],
    Colors.orange[200],
    Colors.deepOrange[200],
  ];
}

//文本样式
class GlobalConstant {
  static const String app_default_share_url =
      "https://github.com/CarGuo/GSYGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    color: Color(GlobalColors.subLightTextColor),
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: Color(GlobalColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: Color(GlobalColors.actionBlue),
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: Color(GlobalColors.miWhite),
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: Color(GlobalColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: Color(GlobalColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: Color(GlobalColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: Color(GlobalColors.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: Color(GlobalColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: Color(GlobalColors.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: Color(GlobalColors.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: Color(GlobalColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: Color(GlobalColors.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: Color(GlobalColors.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: Color(GlobalColors.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  /////////////////search//////////////////////
  static TextStyle defaultStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    decoration: TextDecoration.none,
  );
  static TextStyle fLoorTitleStyle = TextStyle(
    fontSize: 16.0,
    color: GlobalColors.floorTitleColor,
  );
  static TextStyle pinweiCorverSubtitleStyle = TextStyle(
    fontSize: 13.0,
    color: GlobalColors.pinweicorverSubtitleColor,
  );

  static TextStyle cartBottomTotalPriceStyle =
      TextStyle(fontSize: 18, color: GlobalColors.priceColor);

  static TextStyle searchResultItemCommentCountStyle =
      TextStyle(fontSize: 12, color: Color(0xFF999999));
}

class GlobalIcons {
  static const String FONT_FAMILY = 'wxcIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const String DEFAULT_REMOTE_PIC =
      'https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master/static/images/logo.png';
  static const String LOGIN_BACKGROUND_ICON =
      'static/images/login_background.png';
  static const IconData HOME =
      const IconData(0xe624, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData MORE =
      const IconData(0xe674, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData SEARCH =
      const IconData(0xe61c, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData MAIN_DT =
      const IconData(0xe684, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData MAIN_QS =
      const IconData(0xe818, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData MAIN_MY =
      const IconData(0xe6d0, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData MAIN_SEARCH =
      const IconData(0xe61c, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData LOGIN_USER =
      const IconData(0xe666, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData LOGIN_PW =
      const IconData(0xe60e, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER =
      const IconData(0xe63e, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR =
      const IconData(0xe643, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK =
      const IconData(0xe67e, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED =
      const IconData(0xe698, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH =
      const IconData(0xe681, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED =
      const IconData(0xe629, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE =
      const IconData(0xea77, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT =
      const IconData(0xe610, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY =
      const IconData(0xe63e, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION =
      const IconData(0xe7e6, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData USER_ITEM_LINK =
      const IconData(0xe670, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData USER_NOTIFY =
      const IconData(0xe600, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT =
      const IconData(0xe6ba, fontFamily: GlobalIcons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD =
      const IconData(0xe662, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ =
      const IconData(0xe62f, fontFamily: GlobalIcons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
