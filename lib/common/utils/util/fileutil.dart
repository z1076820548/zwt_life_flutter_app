import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  static String root;
  //获取根目录
  static Future<String> getRootPath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String uri = appDocDirectory.path;
    return uri;
  }
}
