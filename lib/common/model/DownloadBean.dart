import 'package:zwt_life_flutter_app/common/model/Chapters.dart';

class DownloadBean {
  String bookId;
  List<Chapters> list;
  int start;
  int end;

  /**
   * 是否已经开始下载
   */
  bool isStartDownload = false;

  /**
   * 是否中断下载
   */
  bool isCancel = false;

  /**
   * 是否下载完成
   */
  bool isFinish = false;


  DownloadBean(this.bookId, this.list, this.start, this.end);
}
