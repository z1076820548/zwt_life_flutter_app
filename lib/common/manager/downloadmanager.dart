import 'dart:io';
import 'package:zwt_life_flutter_app/public.dart';

//下载管理
class DownloadManager {
  static DownloadManager _manager;

  DownloadManager() {}

  static DownloadManager getInstance() {
    if (_manager == null) {
      _manager = new DownloadManager();
    }
    return _manager;
  }

  static Future<String> getChapter(String bookId, int chapter) async {
    File file = FileUtil.getChapterFile(bookId, chapter);
    return await FileUtil.readFile(file);
  }

  static saveChapter(String bookId, int chapter, String contents) async {
    File file = FileUtil.getChapterFile(bookId, chapter);
    await FileUtil.writeFile(file, contents);
  }
}
