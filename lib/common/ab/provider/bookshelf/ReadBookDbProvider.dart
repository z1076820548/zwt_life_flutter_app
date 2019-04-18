import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/SqlProvider.dart';
import 'package:zwt_life_flutter_app/public.dart';

/**
 * 本地已读历史表
 */
final String name = 'ReadBook';
final String columnId = "_id";
final String columnBookId = "bookId";
final String columnChapterIndex = "chapterIndex";
final String columnPageIndex = "pageIndex";

class ReadBooks {
  int id;
  String bookId;
  int chapterIndex ;
  int pageIndex ;

  ReadBooks(this.bookId, this.chapterIndex, this.pageIndex);

  Map<String, dynamic> toMap(String bookId,int chapterIndex,int pageIndex) {
    var map = <String, dynamic>{
      columnBookId:bookId,
      columnChapterIndex: chapterIndex,
      columnPageIndex: pageIndex
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  ReadBooks.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    bookId = map[columnBookId];
    chapterIndex = map[columnChapterIndex];
    pageIndex = map[columnPageIndex];
  }
}

class ReadBookDbProvider extends BaseDbProvider {
  int id;
  String bookId;
  int chapterIndex;
  int pageIndex;

  ReadBookDbProvider();

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnBookId text ,
        $columnChapterIndex int ,
        $columnPageIndex int )
      ''';
  }

  @override
  tableName() {
    return name;
  }

  Future<ReadBooks> getReadBooks(String bookId) async {
    Database db = await getDataBase();
    List<Map> maps = await db.query(tableName(),
        columns: [columnId, columnBookId, columnChapterIndex, columnPageIndex],
        where: '$columnBookId = ?',
        whereArgs: [bookId]);
    if (maps.length > 0) {
      return ReadBooks.fromMap(maps.first);
    }
    return null;
  }

  Future<ReadBooks> insert(ReadBooks readBooks) async {
    Database db = await getDataBase();
    var provider = await getReadBooks(readBooks.bookId);
    if (provider != null) {
      await db.update(tableName(), readBooks.toMap(readBooks.bookId,readBooks.chapterIndex,readBooks.pageIndex),
          where: "$columnBookId = ?", whereArgs: [readBooks.bookId]);
    } else {
      readBooks.id = await db.insert(tableName(), readBooks.toMap(readBooks.bookId,readBooks.chapterIndex,readBooks.pageIndex));
    }
  }
}
