import 'package:zwt_life_flutter_app/common/config/Config.dart';

///地址数据
class Address {
  static const String baseUrl1 = "https://m.image.so.com";
  static const String baseUrl2 = 'https://suggest.taobao.com';
  ///获取授权  post
  static getAuthorization() {
    return "${baseUrl1}authorizations";
  }



  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }
}
