class ChatUser {
  String userId;

  String userName;

  String userIconUrl;
  ChatData chatData;

//  String get UserId => userId;

  String get UserName => userName;

  String get UserIconUrl => userIconUrl;

  ChatData get ChatDt => chatData;

  ChatUser(this.userId, this.userName, this.userIconUrl, this.chatData);
}

class ChatData {
  String text;
  String imageUrl;

  String get Text => text;

  String get ImageUrl => imageUrl;

  ChatData(this.text, this.imageUrl);
}
