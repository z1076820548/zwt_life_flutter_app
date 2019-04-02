class StringUtils {
  static String creatAcacheKey(List<String> list) {
    String key = "";
    for (int i = 0; i < list.length; i++) {
      key += "-" + list[i];
    }
    return key.replaceFirst("-", "");
  }

  /**
   * 格式化小说内容。
   * <p/>
   * <li>小说的开头，缩进2格。在开始位置，加入2格空格。
   * <li>所有的段落，缩进2格。所有的\n,替换为2格空格。
   *
   * @param str
   * @return
   */
  static String formatContent(String str) {
    str = str.replaceAll("[ ]*", ""); //替换来自服务器上的，特殊空格
    str = str.replaceAll("[ ]*", ""); //
    str = str.replaceAll("\n\n", "\n");
    str = str.replaceAll("\n", "\n" + getTwoSpaces());
    str = getTwoSpaces() + str;
//        str = convertToSBC(str);
    return str;
  }

  /**
   * Return a String that only has two spaces.
   *
   * @return
   */
  static String getTwoSpaces() {
    return "\u3000\u3000";
  }
}
