import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';

enum DownloadEventType { start, cancel, pause, resume, fail, remove,finish,loading}

class DownloadEvent {
  String bookId;
  List<Chapters> list;
  int start;
  int end;
  DownloadEventType type;

  DownloadEvent(this.bookId, this.list, this.start, this.end, this.type);

}
