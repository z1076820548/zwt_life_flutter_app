import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';

class DownloadEventType {
 static  String start = 'start';
 static String cancel = 'cancle';
 static String pause = 'pause';
 static String resume = 'resume';
 static String fail = 'fail';
 static String remove = 'remove';
 static String finish = 'finish';
 static String loading = 'loading';
}

class DownloadEvent {
  String bookId;
  List<Chapters> list;
  int start;
  int end;
  String type;
  int current;

  DownloadEvent(this.bookId, this.list, this.start, this.end, this.type,
      {this.current});

  DownloadEvent.fromJsonMap(Map<String, dynamic> map)
      : bookId = map["bookId"],
        start = map["start"],
        end = map["end"],
        type = map["type"],
        current = map["current"],
        list =
            List<Chapters>.from(map["list"].map((it) => Chapters.fromJson(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = bookId;
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    data['current'] = current;
    data['list'] =
        list != null ? this.list.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
