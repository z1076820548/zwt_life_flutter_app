import 'dart:convert';

import 'package:zwt_life_flutter_app/common/net/Address.dart';
import 'package:zwt_life_flutter_app/common/net/Api.dart';
import 'package:zwt_life_flutter_app/common/net/ResultData.dart';

dioGetSearchResult(String keyworld, [int page = 0]) async {
  String url = Address.host + 'ware/search._m2wq_list?';
  Map<String, String> requestParams = {
    "keyword": "$keyworld",
    "datatype": "1",
    "callback": "C",
    "page": "$page",
    "pagesize": "10",
    "ext_attr": "no",
    "brand_col": "no",
    "price_col": "no",
    "color_col": "no",
    "size_col": "no",
    "ext_attr_sort": "no",
    "merge_sku": "yes",
    "multi_suppliers": "yes",
    "area_ids": "1,72,2818",
    "qp_disable": "no",
    "fdesc": "%E5%8C%97%E4%BA%AC",
  };

  ResultData res = await HttpManager.netFetch(url, requestParams, null, null);
  String body = res.data;
  String jsonString = body.substring(2, body.length - 2);

  //  debugPrint(jsonString.replaceAll('\\x2F', '/'));
  var json = jsonDecode(jsonString.replaceAll(RegExp(r'\\x..'), '/'));
  return json['data']['searchm']['Paragraph'] as List;
}

dioGetHotSugs() async {
  String url = 'https://suggest.taobao.com/sug?';
  Map<String, String> requestParams = {
    "area": "sug_hot",
    "wireless": "2",
  };
  ResultData res = await HttpManager.netFetch(url, requestParams, null, null);
  if (res != null && res.result) {
    List querys = jsonDecode(res.data)['querys'] as List;
    return querys;
  } else {
    return [];
  }
}

dioGetSuggest(String q) async {
  String url = 'https://suggest.taobao.com/sug?';
  Map<String, String> requestParams = {
    "q": "$q",
    "code": "utf-8",
    "area": "c2c",
  };
  ResultData res = await HttpManager.netFetch(url, requestParams, null, null);
  if (res != null && res.result) {
    List data = jsonDecode(res.data)['result'] as List;
    return data;
  } else {
    return [];
  }
}
