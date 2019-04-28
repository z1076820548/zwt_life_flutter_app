import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zwt_life_flutter_app/common/model/BookDetailBean.dart';
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
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    return Data(map, true);
  } else {
    return Data("", false);
  }
}

//获取排行榜详情
dioGetRankingDetail(String rankingId) async {
  String url = Constant.API_BASE_URL;
  String path = "/ranking/$rankingId";
  Map<String, String> requestParams = {};
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    RankingBean rankingBean = RankingBean.fromJson(map['ranking']);
    return Data(rankingBean, true);
  } else {
    return Data("", false);
  }
}

//获取小说详情
dioGetBookDetail(String bookId) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/$bookId";
  Map<String, String> requestParams = {};
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    BookDetailBean bookDetailBean = BookDetailBean.fromJson(map);
    return Data(bookDetailBean, true);
  } else {
    return Data("", false);
  }
}

//获取小说标签
dioGetBookByTags(String tags, String start, String limit) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/by-tags";
  Map<String, String> requestParams = {
    'tags': tags,
    'start': start,
    'limit': limit,
  };
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    List<TagBookBean> list = new List();
    list = (map['books'] as List)
        ?.map((e) =>
            e == null ? null : TagBookBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
    return Data(list, true);
  } else {
    return Data("", false);
  }
}

//获取分类
dioGetCategoryList() async {
  String url = Constant.API_BASE_URL;
  String path = "/cats/lv2/statistics";
  Map<String, String> requestParams = {};
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    CategoryList categoryList = new CategoryList.fromJsonMap(map);
    return Data(categoryList, true);
  } else {
    return Data("", false);
  }
}

//获取二级分类
dioGetCategoryList2() async {
  String url = Constant.API_BASE_URL;
  String path = "/cats/lv2";
  Map<String, String> requestParams = {};
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    CategoryList2 categoryList2 = new CategoryList2.fromJsonMap(map);
    return Data(categoryList2, true);
  } else {
    return Data("", false);
  }
}

//分类详情
dioGetBooksByCats(
    {String gender,
    String major,
    String minor,
    String type,
    int start,
    int limit}) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/by-categories";
  Map<String, String> requestParams = {
    "gender": '$gender',
    "major": '$major',
    "minor": '$minor',
    "type": '$type',
    "start": '$start',
    "limit": '$limit',
  };
  ResultData res =
      await HttpManager.netFetch(url, path, requestParams, method: 'GET');
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    List<BooksBean> list = (map['books'] as List)
        ?.map((e) =>
            e == null ? null : BooksBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
    return Data(list, true);
  } else {
    return Data("", false);
  }
}

//搜索热词
dioGetHotSugs() async {
  String url = Constant.API_BASE_URL;
  String path = "/book/hot-word";
  Map<String, String> requestParams = {};
  ResultData res = await HttpManager.netFetch(url, path, requestParams);
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    HotWordBean hotWordBean = HotWordBean.fromJsonMap(map);
    return Data(hotWordBean, true);
  } else {
    return Data("", false);
  }
}


//关键字自动补全
dioGetAutoComplete(String query) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/auto-complete";
  Map<String, String> requestParams = {
    'query':query,
  };
  ResultData res = await HttpManager.netFetch(url, path, requestParams);
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    List<String> list =(map['keywords'] as List)?.map((e) => e as String)?.toList();
    return Data(list, true);
  } else {
    return Data("", false);
  }
}

//书籍查询
dioGetSearchBooks(String query) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/fuzzy-search";
  Map<String, String> requestParams = {
    'query':query,
  };
  ResultData res = await HttpManager.netFetch(url, path, requestParams);
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    List<BooksBean> list = (map['books'] as List)
        ?.map((e) =>
    e == null ? null : BooksBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
    return Data(list, true);
  } else {
    return Data("", false);
  }
}


//通过作者查询书籍
dioGetSearchBooksByAuthor(String author) async {
  String url = Constant.API_BASE_URL;
  String path = "/book/accurate-search";
  Map<String, String> requestParams = {
    'author':author,
  };
  ResultData res = await HttpManager.netFetch(url, path, requestParams);
  if (res != null && res.result) {
    Map map = json.decode(res.data.toString());
    List<BooksBean> list = (map['books'] as List)
        ?.map((e) =>
    e == null ? null : BooksBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
    return Data(list, true);
  } else {
    return Data("", false);
  }
}