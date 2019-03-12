import 'package:zwt_life_flutter_app/common/config/Config.dart';

///地址数据
class Address {
  static const String host = "https://m.image.so.com/";

  ///获取授权  post
  static getAuthorization() {
    return "${host}authorizations";
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
