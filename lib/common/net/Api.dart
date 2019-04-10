import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'dart:collection';
import 'package:connectivity/connectivity.dart';
import 'package:zwt_life_flutter_app/common/local/LocalStorage.dart';
import 'package:zwt_life_flutter_app/common/net/HeaderInterceptor.dart';
import 'ResultData.dart';
import 'Code.dart';
import 'package:zwt_life_flutter_app/common/config/Config.dart';

///http请求
class HttpManager {
  static final String TAG = "uriHttpManager#";
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[path] 请求路径
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置 get post
  static netFetch(baseUrl, String path, params,
      {noTip = false,
      Options option,
      Map<String, String> header,
      String method}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
//    if (optionParams["authorizationCode"] == null) {
//      var authorizationCode = await getAuthorization();
//      if (authorizationCode != null) {
//        optionParams["authorizationCode"] = authorizationCode;
//      }
//    }
//
//    headers["Authorization"] = optionParams["authorizationCode"];

    if (option != null) {
      option.headers = headers;
    } else {
      if (method == null) {
        //默认为空时 为get请求
        method = "GET";
      }
      option = new Options(
        method: method,
        headers: headers,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      );
    }

    ///超时
    option.connectTimeout = 15000;
    Dio dio = new Dio();
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(CookieManager(CookieJar()));
    Response response;
    try {
      response =
          await dio.request(path, queryParameters: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print(TAG + '请求异常: ' + e.toString());
        print(TAG + '请求异常path: ' + path);
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }


    if (Config.DEBUG) {
      print(TAG +
          '请求头: ' +
          option.headers.toString() +
          "请求方式：" +
          option.method.toString());
      if (response != null) {
        print(TAG + '返回参数: ' + response.toString());
      }
    }

    try {
      if (option.contentType != null &&
          option.contentType.primaryType == "text") {
        return new ResultData(response.toString, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 && responseJson["token"] != null) {
          optionParams["authorizationCode"] = 'token ' + responseJson["token"];
          await LocalStorage.save(
              Config.TOKEN_KEY, optionParams["authorizationCode"]);
        }
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + baseUrl + path);
      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }

  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  static getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      optionParams["authorizationCode"] = token;
      return token;
    }
  }
}
