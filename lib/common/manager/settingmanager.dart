import 'package:zwt_life_flutter_app/common/base/Constant.dart';
import 'package:zwt_life_flutter_app/common/model/support/BookMark.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/main.dart';

//设置管理
class SettingManager {
  static SettingManager _manager;

  static SettingManager getInstance() {
    return _manager != null ? _manager : (_manager = new SettingManager());
  }
  /**
   * 保存全局生效的阅读字体大小
   *
   * @param fontSizePx
   */
  String getFontSizeKey() {
    return "-readFontSize";
  }

  String getLetterHeightKey() {
    return "-readLetterHeight";
  }

  String getLetterSpacingKey() {
    return "-readLetterSpacing";
  }

  void saveFontSize(int fontSizePx) {
    sp.putInt(getFontSizeKey(), fontSizePx);
  }

  void saveLetterHeight(double height) {
    sp.putDouble(getLetterHeightKey(), height);
  }

  void saveLetterSpacing(double widght) {
    sp.putDouble(getLetterSpacingKey(), widght);
  }

  int getReadFontSize() {
    return sp.getInt(getFontSizeKey(), 19);
  }

  double getLetterHeight() {
    return sp.getDouble(getLetterHeightKey(),1.25);
  }

  double getLetterSpacing() {
    return sp.getDouble(getLetterSpacingKey(),1.25);
  }

//  int getReadBrightness() {
//    return sp.getScreenBrightness();
//  }

  /**
   * 获取上次阅读章节及位置
   *
   * @param bookId
   * @return
   */
  List<int> getReadProgress(String bookId) {
    int lastChapter = sp.getInt(getChapterKey(bookId), 1);
    int startPos = sp.getInt(getStartPosKey(bookId), 0);
    int endPos = sp.getInt(getEndPosKey(bookId), 0);

    return [lastChapter, startPos, endPos];
  }

  void removeReadProgress(String bookId) {
    sp.remove(getChapterKey(bookId));
    sp.remove(getStartPosKey(bookId));
    sp.remove(getEndPosKey(bookId));
  }

  String getChapterKey(String bookId) {
    return bookId + "-chapter";
  }

  String getStartPosKey(String bookId) {
    return bookId + "-startPos";
  }

  String getEndPosKey(String bookId) {
    return bookId + "-endPos";
  }

//  bool addBookMark(String bookId, BookMark mark) {
//    List<String> list = sp.getStringList(
//        getBookMarksKey(bookId));
//    if (list != null && list.length > 0) {
//      for (BookMark item : marks) {
//        if (item.chapter == mark.chapter && item.startPos == mark.startPos) {
//          return false;
//        }
//      }
//    } else {
//      list = new List();
//    }
//    list.add(mark);
//    sp.putObject(getBookMarksKey(bookId), marks);
//    return true;
//  }

//  List<BookMark> getBookMarks(String bookId) {
//    return sp.getObject(getBookMarksKey(bookId), ArrayList.class);
//  }

  void clearBookMarks(String bookId) {
    sp.remove(getBookMarksKey(bookId));
  }

  String getBookMarksKey(String bookId) {
    return bookId + "-marks";
  }

  void saveReadTheme(int theme) {
    sp.putInt("readTheme", theme);
  }

  int getReadTheme() {
    if (sp.getBool(Constant.ISNIGHT, false)) {
//      return ThemeManager.NIGHT;
    }
    return sp.getInt("readTheme", 3);
  }

  /**
   * 保存用户选择的性别
   *
   * @param sex male female
   */
  void saveUserChooseSex(String sex) {
    sp.putString("userChooseSex", sex);
  }

  /**
   * 获取用户选择性别
   *
   * @return
   */
  String getUserChooseSex() {
    String s = sp.getString("userChooseSex", Constant.MALE);
    return s == null ? Constant.MALE:s;
  }

  bool isUserChooseSex() {
    if (sp.getString("userChooseSex", null) == null ||
        sp.getString("userChooseSex", null).toString().length == 0) {
      return false;
    } else {
      return true;
    }
  }

  bool isNoneCover() {
    return sp.getBool("isNoneCover", false);
  }

  void saveNoneCover(bool isNoneCover) {
    sp.putBool("isNoneCover", isNoneCover);
  }
}
