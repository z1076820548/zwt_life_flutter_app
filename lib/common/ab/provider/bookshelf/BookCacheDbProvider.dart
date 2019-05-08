import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/SqlProvider.dart';
import 'package:zwt_life_flutter_app/common/event/DownloadEvent.dart';
import 'package:zwt_life_flutter_app/common/model/RecommendBooks.dart';
import 'package:zwt_life_flutter_app/common/utils/util/codeutil.dart';

/**
 * 书籍缓存表
 */

class BookCacheDbProvider extends BaseDbProvider {
  final String name = 'BookCache';
  final String columnId = "_id";
  final String columnBookId = "bookId";
  final String columnData = "data";

  int id;
  String bookId;
  String data;

  BookCacheDbProvider();

  Map<String, dynamic> toMap(String bookId, String data) {
    Map<String, dynamic> map = {columnBookId: bookId, columnData: data};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  BookCacheDbProvider.fromMap(Map map) {
    id = map[columnId];
    bookId = map[columnBookId];
    data = map[columnData];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnBookId text ,
        $columnData text )
      ''';
  }

  @override
  tableName() {
    return name;
  }

  //获取所有
  Future _getProviderAll(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(
      name,
      columns: [columnId, columnBookId, columnData],
    );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  //单条查询
  Future _getProviderOne(Database db, String bookId) async {
    List<Map<String, dynamic>> maps = await db.query(
      name,
      columns: [columnId, columnBookId, columnData],
      where: "$columnBookId = ?",
      whereArgs: [bookId],
    );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  ///单条插入到数据库
  Future insert(String bookId, String dataMapString) async {
    Database db = await getDataBase();
    var provider = await _getProviderOne(db, bookId);
    if (provider != null) {
      await db.update(name, toMap(bookId, dataMapString),
          where: "$columnBookId = ?", whereArgs: [bookId]);
    } else {
      return await db.insert(name, toMap(bookId, dataMapString));
    }
  }

  Future<int> delete(String bookId) async {
    Database db = await getDataBase();
    return await db
        .delete(name, where: '$columnBookId = ?', whereArgs: [bookId]);
  }

  ///获取所有事件数据
  Future<List<DownloadEvent>> getAllData() async {
    Database db = await getDataBase();
    var provider = await _getProviderAll(db);
    if (provider != null) {
      List<DownloadEvent> list = new List();
      for (var providerMap in provider) {
        BookCacheDbProvider provider = BookCacheDbProvider.fromMap(providerMap);
        var mapData = json.decode(provider.data);

        list.add(DownloadEvent.fromJsonMap(mapData));
      }
      return list;
    }
    return [];
  }

  ///获取单条数据
  Future<DownloadEvent> getOneData(String bookId) async {
    Database db = await getDataBase();
    var provider = await _getProviderOne(db, bookId);
    if (provider != null) {
      List<DownloadEvent> list = new List();
      for (var providerMap in provider) {
        BookCacheDbProvider provider = BookCacheDbProvider.fromMap(providerMap);

        print('1111111111' + provider.data.toString());
        ///使用 compute 的 Isolate 优化 json decode
        var mapData = json.decode(provider.data.toString());

        list.add(DownloadEvent.fromJsonMap(mapData));
      }
      return list[0];
    }
    return null;
  }
}
