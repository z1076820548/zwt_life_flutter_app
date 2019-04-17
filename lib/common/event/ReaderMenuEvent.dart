import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';

enum ReaderMenuType{catlog,lighting,fontsize,background,readTheme}

class ReaderMenuEvent {
  ReaderMenuType readerMenuType;
  var data;
  ReaderMenuEvent(this.readerMenuType,this.data);
}
