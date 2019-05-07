import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/event/DownloadEvent.dart';
import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';


class DownloadStatusEvent with ChangeNotifier{

  String bookId;
  int start;
  int end;

  DownloadEventType type;

  DownloadStatusEvent(this.bookId, this.start, this.end, this.type);

  void notifyDownload(bookId,start,end,type){
    this.bookId = bookId;
    this.start = start;
    this.end = end;
    this.type = type;
    notifyListeners();
  }

}
