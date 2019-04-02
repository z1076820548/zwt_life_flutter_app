import 'package:zwt_life_flutter_app/public.dart';

class Constant {
  static final String IMG_BASE_URL = "http://statics.zhuishushenqi.com";

  static final String API_BASE_URL = "http://api.zhuishushenqi.com";

  static String PATH_DATA = FileUtil.root + "/cache";

  static String PATH_COLLECT = FileUtil.root + "/collect";

  static String PATH_TXT = PATH_DATA + "/book/";

  static String PATH_EPUB = PATH_DATA + "/epub";

  static String PATH_CHM = PATH_DATA + "/chm";

//  static String BASE_PATH = AppUtils.getAppContext().getCacheDir().getPath();

  static final String ISNIGHT = "isNight";

  static final String ISBYUPDATESORT = "isByUpdateSort";
  static final String FLIP_STYLE = "flipStyle";

  static final String SUFFIX_TXT = ".txt";
  static final String SUFFIX_PDF = ".pdf";
  static final String SUFFIX_EPUB = ".epub";
  static final String SUFFIX_ZIP = ".zip";
  static final String SUFFIX_CHM = ".chm";


  static String MALE = "male";

  static String FEMALE = "female";
}