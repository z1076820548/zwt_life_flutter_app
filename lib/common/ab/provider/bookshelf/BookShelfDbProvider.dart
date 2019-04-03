import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/BaseDbProvider.dart';

/**
 * 本地已读历史表
 * Created by guoshuyu
 * Date: 2018-08-07
 */

class BookShelfDbProvider extends BaseDbProvider {
  final String name = 'BookShelf';
  final String columnId = "_id";
  final String columnReadDate = "readDate";
  final String columnData = "data";

  int id;
  String bookId;
  int readDate;
  String data;

  BookShelfDbProvider();

  Map<String, dynamic> toMap(DateTime readDate, String data) {
    Map<String, dynamic> map = {
      columnReadDate: readDate.millisecondsSinceEpoch,
      columnData: data
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  BookShelfDbProvider.fromMap(Map map) {
    id = map[columnId];
    bookId = map[columnBookId];
    readDate = map[columnReadDate];
    data = map[columnData];
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnReadDate int not null,
        $columnData text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  //获取所有
  Future _getProvider(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, columnReadDate, columnData],
        orderBy: "$columnReadDate DESC");
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  //单条查询
  Future _getProviderInsert(Database db, String columnId) async {
    List<Map<String, dynamic>> maps = await db.query(
      name,
      columns: [columnId, columnReadDate, columnData],
      where: "$columnId = ?",
      whereArgs: [columnId],
    );
    if (maps.length > 0) {
      BookShelfDbProvider provider = BookShelfDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///单条插入到数据库
  Future insert(String columnId, DateTime dateTime, String dataMapString) async {
    Database db = await getDataBase();
    var provider = await _getProviderInsert(db, columnId);
    if (provider != null) {
      await db.update(name, toMap(dateTime, dataMapString),
          where: "$columnId = ?", whereArgs: [columnId]);
    } else {
      return await db.insert(name, toMap(dateTime, dataMapString));
    }
  }

  ///获取事件数据
  Future<List<Repository>> geData(int page) async {
    Database db = await getDataBase();
    var provider = await _getProvider(db, page);
    if (provider != null) {
      List<Repository> list = new List();
      for (var providerMap in provider) {
        BookShelfDbProvider provider = BookShelfDbProvider.fromMap(providerMap);

        ///使用 compute 的 Isolate 优化 json decode
        var mapData = await compute(CodeUtils.decodeMapResult, provider.data);

        list.add(Repository.fromJson(mapData));
      }
      return list;
    }
    return null;
  }
}
