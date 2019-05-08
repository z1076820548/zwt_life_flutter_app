import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/event/DownloadEvent.dart';
import 'package:zwt_life_flutter_app/common/model/Chapters.dart';
import 'package:zwt_life_flutter_app/common/model/DownloadBean.dart';

class DownloadStatusEvent with ChangeNotifier {
  String bookId;
  int start;
  int end;
  int current;
  String type;
  List<Chapters> list;

  DownloadStatusEvent(this.bookId, this.start, this.end, this.type);

  void notifyDownload(String bookId, int start, int end, String type,
      {int current, List<Chapters> list}) {
    this.bookId = bookId;
    this.start = start;
    this.end = end;
    this.type = type;
    this.current = current == null ? start : current;
    this.list = list == null ? [] : list;
    notifyListeners();
  }
}
