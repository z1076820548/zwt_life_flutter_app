class ChatUser {
  String userId;

  String userName;

  String userIconUrl;

  ChatData chatData;

//  String get UserId => userId;

  String get UserName => userName;

  String get UserIconUrl => userIconUrl;

  ChatData get ChatDt => chatData;

  ChatUser({
    this.userId,
    this.userName,
    this.userIconUrl,
    this.time,
    this.chatData,
  });

  var time;
}

class ChatData {
  String text;
  String imageUrl;
  String voicePath;

  String get Text => text;

  String get ImageUrl => imageUrl;

  String get VoicePath => voicePath;

  String timeRecorder;

  ChatData({this.text, this.imageUrl, this.voicePath,this.timeRecorder});
}
