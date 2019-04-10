import 'package:dio/dio.dart';

class HeaderInterceptor implements Interceptor {
  @override
  onError(DioError err) {
    // TODO: implement onError
    return null;
  }

  @override
  onRequest(RequestOptions options) {
    String url = options.uri.toString();
    if (url.contains("book/") ||
        url.contains("book-list/") ||
        url.contains("toc/") ||
        url.contains("post/") ||
        url.contains("user/")) {
      Map<String,dynamic> map = {
        "User-Agent":
            "ZhuiShuShenQi/3.40[preload=false;locale=zh_CN;clientidbase=android-nvidia]",
        "X-User-Agent":
            "ZhuiShuShenQi/3.40[preload=false;locale=zh_CN;clientidbase=android-nvidia]",
        "X-Device-Id": "1231",
        "Host": "api.zhuishushenqi.com",
        "Connection": "Keep-Alive",
        "If-None-Match": "W/\"2a04-4nguJ+XAaA1yAeFHyxVImg\"",
        "If-Modified-Since": "Tue, 02 Aug 2016 03:20:06 UTC",
      };
      options.headers.addAll(map);
    }
    // TODO: implement onRequest
    return options;
  }

  @override
  onResponse(Response response) {
    // TODO: implement onResponse
    return response;
  }
}
