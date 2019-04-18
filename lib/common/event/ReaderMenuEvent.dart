import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';

enum ReaderMenuType{catlog,lighting,fontsize,background,readTheme,catchDownLoad,rowSpacing}

class ReaderMenuEvent {
  ReaderMenuType readerMenuType;
  var data;
  ReaderMenuEvent(this.readerMenuType,this.data);
}
