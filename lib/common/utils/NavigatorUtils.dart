import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/page/MainPage.dart';
import 'package:zwt_life_flutter_app/page/LoginPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BookCachePage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BookDetailPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BooksByTagPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/CategoryListDetailPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/FindBookPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/OtherRankingPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/RankingPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/ReadBookPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/TopCategoryPage.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/TopRankPage.dart';
import 'package:zwt_life_flutter_app/page/searchpage/SearchPage.dart';
import 'package:zwt_life_flutter_app/page/searchpage/SearchResultListPage.dart';

class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, MainPage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }


  ///搜索
  static Future goSearchPage(BuildContext context) {
    return NavigatorRouter(context, new SearchPage());
  }

  ///搜索结果
  static Future goSearchResultListPage(BuildContext context, String keyWord) {
    return NavigatorRouter(
        context,
        new SearchResultListPage(
          keyword: keyWord,
        ));
  }

  ///搜索界面
  static gotoSearchPage(BuildContext context) {
    NavigatorRouter(context, new SearchPage());
  }


  ///排行榜
  static gotoTopRankPage(BuildContext context) {
    NavigatorRouter(context, new TopRankPage());
  }

  ///排行榜详情
  static gotoRankingPage(BuildContext context, String week, String month,
      String all, String title) {
    NavigatorRouter(
        context,
        new RankingPage(
          week: week,
          month: month,
          all: all,
          title: title,
        ));
  }

  ///其他家排行榜详情
  static gotoOtherRankingPage(
      BuildContext context, String bookId, String title) {
    NavigatorRouter(
        context,
        new OtherRankingPage(
          title: title,
          bookId: bookId,
        ));
  }

  ///阅读界面
  static gotoReadBookPage(
      BuildContext context, String bookTitle, String bookId) {
    NavigatorRouter(
        context,
        new ReadBookPage(
          bookId: bookId,
          bookTitle: bookTitle,
        ));
  }

  ///找书
  static gotoFindBookPage(BuildContext context) {
    NavigatorRouter(context, new FindBookPage());
  }

  ///小说详情
  static gotoBookDetailPage(BuildContext context, String bookId) {
    NavigatorRouter(
        context,
        new BookDetailPage(
          bookId: bookId,
        ));
  }

  ///小说标签
  static gotoBookByTagsPage(BuildContext context, String tag, String type) {
    NavigatorRouter(
        context,
        new BooksByTagPage(
          tag: tag,
          type: type,
        ));
  }

  //小说分类
  static gotoTopCategoryPage(BuildContext context) {
    NavigatorRouter(context, new TopCategoryPage());
  }

  //小说二级分类
  static gotoCategoryListDetailPage(
      BuildContext context, String cate, String gender) {
    NavigatorRouter(
        context,
        new CategoryListDetailPage(
          cate: cate,
          gender: gender,
        ));
  }

  static gotoBookCachePage(BuildContext context){
    NavigatorRouter(context, new BookCachePage());
  }


  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => widget));
  }
}
