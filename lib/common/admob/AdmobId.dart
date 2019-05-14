import 'dart:io';

class AdmobId {
  static String AndroidAppId = "ca-app-pub-3487865750845286~8249904505";
  static String AndroidCYId = 'ca-app-pub-3487865750845286/1914885859';
  static String AndroidHFId = 'ca-app-pub-3487865750845286/8204962030';
  static String AndroidJLId = 'ca-app-pub-3487865750845286/9166689918';

  static String IOSAppId = "ca-app-pub-3487865750845286~4055508621";
  static String IOSHFId = 'ca-app-pub-3487865750845286/7598457374';
  static String IOSCYId = 'ca-app-pub-3487865750845286/3276068983';
  static String IOSJLId = 'ca-app-pub-3487865750845286/7762108904';

  static final String AppId = Platform.isAndroid ? AndroidAppId : IOSAppId;
  static final String BannerId  = Platform.isAndroid ? AndroidHFId : IOSHFId;
  static final String InterstitialId  = Platform.isAndroid ? AndroidCYId : IOSCYId;
  static final String RewardedVideoId  = Platform.isAndroid ? AndroidJLId : IOSJLId;
}
