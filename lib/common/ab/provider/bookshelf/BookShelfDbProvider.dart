import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/BaseDbProvider.dart';
import 'package:zwt_life_flutter_app/common/model/RecommendBooks.dart';
import 'package:zwt_life_flutter_app/common/utils/util/codeutil.dart';

/**
 * 本地已读历史表
 * Created by guoshuyu
 * Date: 2018-08-07
 */

class BookShelfDbProvider extends BaseDbProvider {
  final String name = 'BookShelf';
  final String columnId = "_id";
  final String columnBookId = "bookId";
  final String columnReadDate = "readDate";
  final String columnData = "data";

  int id;
  String bookId;
  int readDate;
  String data;

  BookShelfDbProvider();

  Map<String, dynamic> toMap(
      String columnBookId, DateTime readDate, String data) {
    Map<String, dynamic> map = {
      columnReadDate: readDate.millisecondsSinceEpoch,
      columnBookId: columnBookId,
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
        $columnBookId text not null
        $columnReadDate int not null,
        $columnData text not null)
      ''';
  }

  @override
  tableName() {
    return name;
  }

  //获取所有
  Future _getProviderAll(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, columnBookId, columnReadDate, columnData],
        orderBy: "$columnReadDate DESC");
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  //单条查询
  Future _getProviderOne(Database db, String columnBookId) async {
    List<Map<String, dynamic>> maps = await db.query(
      name,
      columns: [columnId, columnReadDate, columnData],
      where: "$columnBookId = ?",
      whereArgs: [columnBookId],
    );
    if (maps.length > 0) {
      BookShelfDbProvider provider = BookShelfDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///单条插入到数据库
  Future insert(
      String columnBookId, DateTime dateTime, String dataMapString) async {
    Database db = await getDataBase();
    var provider = await _getProviderOne(db, columnBookId);
    if (provider != null) {
      await db.update(name, toMap(columnBookId, dateTime, dataMapString),
          where: "$columnBookId = ?", whereArgs: [columnBookId]);
    } else {
      return await db.insert(
          name, toMap(columnBookId, dateTime, dataMapString));
    }
  }

  ///获取所有事件数据
  Future<List<RecommendBooks>> getAllData() async {
    Database db = await getDataBase();
    var provider = await _getProviderAll(db);
    if (provider != null) {
      List<RecommendBooks> list = new List();
      for (var providerMap in provider) {
        BookShelfDbProvider provider = BookShelfDbProvider.fromMap(providerMap);
        ///使用 compute 的 Isolate 优化 json decode
        var mapData = await compute(CodeUtils.decodeMapResult, provider.data);

        list.add(RecommendBooks.fromJson(mapData));
      }
      return list;
    }
    return null;
  }


  ///获取单条数据
  Future<List<RecommendBooks>> getOneData(String columnBookId) async {
    Database db = await getDataBase();
    var provider = await _getProviderOne(db,columnBookId);
    if (provider != null) {
      List<RecommendBooks> list = new List();
      for (var providerMap in provider) {
        BookShelfDbProvider provider = BookShelfDbProvider.fromMap(providerMap);
        ///使用 compute 的 Isolate 优化 json decode
        var mapData = await compute(CodeUtils.decodeMapResult, provider.data);

        list.add(RecommendBooks.fromJson(mapData));
      }
      return list;
    }
    return null;
  }
}
