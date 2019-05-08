import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/event/DownloadEvent.dart';
import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';


class DownloadStatusEvent with ChangeNotifier{

  String bookId;
  int start;
  int end;
  int current;
  DownloadEventType type;

  DownloadStatusEvent(this.bookId, this.start, this.end, this.type);

  void notifyDownload(String bookId,int start,int end,DownloadEventType type,{int current}){
    this.bookId = bookId;
    this.start = start;
    this.end = end;
    this.type = type;
    this.current = current == null ? start:current;
    notifyListeners();
  }

}
