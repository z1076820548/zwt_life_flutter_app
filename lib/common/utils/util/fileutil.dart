import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:zwt_life_flutter_app/public.dart';

class FileUtil {
  //在main已设置
  static String root;

  //获取应用目录
  static Future<String> getRootPath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String uri = appDocDirectory.path;
    return uri;
  }

  static String getChapterPath(String bookId, int chapter) {
    return Constant.PATH_TXT + bookId + '/' + chapter.toString() + '.txt';
  }

  static File getChapterFile(String bookId, int chapter) {
    File file = new File(root + getChapterPath(bookId, chapter));
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  static writeFile(File file, String contents) async {
    await file.writeAsString(contents);
  }

  static Future<String> readFile(File file) async {
    String contents = await file.readAsStringSync();
    return contents;
  }
}
