import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zwt_life_flutter_app/common/net/Api.dart';
import 'package:zwt_life_flutter_app/public.dart';

//收藏栏
dioGetRecommend(String gender) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/recommend";
  Map<String, String> requestParams = {
    "gender": "$gender",
  };
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  List<RecommendBooks> recommendBooksList = new List();
  if (res != null && res.result) {
    Map recommendMap = json.decode(res.data.toString());
    var recommend = Recommend.fromJson(recommendMap);
    for (int i = 0; i < recommend.books.length; i++) {
      var data = recommend.books[i];
      recommendBooksList.add(data);
    }
    return Data(recommendBooksList, true);
  } else {
    return Data("", false);
  }
}

//更新小说章节
dioGetAToc(String bookId, String view) async {
  String url = Constant.API_BASE_URL;
  String path = "/mix-atoc/$bookId";
  Map<String, String> requestParams = {
    "view": "$view",
  };
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  List<Chapters> chaptersList = new List();
  if (res != null && res.result) {
    Map<String, dynamic> tocMap = json.decode(res.data.toString());
    var map = tocMap["mixToc"];
    MixToc mic = MixToc.fromJson(map);
    return Data(mic, true);
  } else {
    return Data("", false);
  }
}

//获取小说章节具体内容
dioGetChapterBody(String link, String title) async {
  link = link.replaceAll("/", "%2F");
  link = link.replaceAll("?", "%3F");
  String url = Constant.API_BASE_URL2;
  String path = "/chapter/$link";
  Map<String, String> requestParams = {};
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    Chapter chapter = Chapter.fromJson(map["chapter"]);
    chapter.title = title;
    return Data(chapter, true);
  } else {
    return Data("", false);
  }
}

//获取排行榜
dioGetTopBank() async {
  String url = Constant.API_BASE_URL;
  String path = "/ranking/gender";
  Map<String, String> requestParams = {};
  ResultData res = await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    return Data(map, true);
  } else {
    return Data("", false);
  }
}