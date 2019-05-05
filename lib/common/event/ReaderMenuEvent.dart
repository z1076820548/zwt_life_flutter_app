
enum ReaderMenuType{catlog,lighting,fontsize,background,readTheme,catcheDownLoad,rowSpacing}

class ReaderMenuEvent {
  ReaderMenuType readerMenuType;
  var data;
  ReaderMenuEvent(this.readerMenuType,this.data);
}
