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

  static String getChapter(String bookId, int chapter)  {
    File file = FileUtil.getChapterFile(bookId, chapter);
    String s =  FileUtil.readFile(file);
    if (s.length > 0) {
      return s;
    } else {
      return "";
    }
  }

  static saveChapter(String bookId, int chapter, String contents) async {
    File file = FileUtil.getChapterFile(bookId, chapter);
    await FileUtil.writeFile(file, contents);
  }

  static removeBook(String bookId) async{
    await FileUtil.deleteChapterFile(bookId);
  }
}
