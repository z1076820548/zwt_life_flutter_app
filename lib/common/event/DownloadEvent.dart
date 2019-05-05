import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';

enum DownloadEventType { start, cancel, pause, resume, fail, remove,finish}

class DownloadEvent {
  DownloadBean downloadBean;
  DownloadEventType type;

  DownloadEvent(this.downloadBean, this.type);
}
