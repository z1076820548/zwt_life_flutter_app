import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zwt_life_flutter_app/common/net/Api.dart';
import 'package:zwt_life_flutter_app/public.dart';

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

dioGetAToc(String bookId,String view) async {
  String url = Constant.API_BASE_URL;
  String path = "/mix-atoc/$bookId";
  Map<String, String> requestParams = {
    "view": "$view",
  };
  ResultData res = await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map tocMap = json.decode(res.data.toString());
    var map = tocMap['mixToc'];
//    for (int i = 0; i < recommend.books.length; i++) {
//      var data = recommend.books[i];
//      recommendBooksList.add(data);
//    }
//    return Data(recommendBooksList, true);
  } else {
    return Data("", false);
  }
}