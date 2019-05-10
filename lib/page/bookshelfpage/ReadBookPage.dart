import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zwt_life_flutter_app/common/event/ChatEvent.dart';
import 'package:zwt_life_flutter_app/common/event/ReaderMenuEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderMenu.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderPageAgent.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderView.dart';
import 'package:zwt_life_flutter_app/public.dart';

enum Todo { toPre, toNext, toOther }
enum PageJumpType { stay, firstPage, lastPage }



//小说阅读界面
class ReadBookPage extends StatefulWidget {
  final String bookId;
  static final String sName = "ReadBook";
  final String bookTitle;

  const ReadBookPage({Key key, this.bookTitle, this.bookId}) : super(key: key);

  @override
  _ReadBookPageState createState() {
    // TODO: implement createState
    return _ReadBookPageState();
  }
}

class _ReadBookPageState extends State<ReadBookPage> with RouteAware {
  // 是否开始阅读章节
  bool startRead = false;

  //当前第几页
  int pageIndex = 0;

  //当前的章节  第一章
  int currentChapterIndex = 0;

  bool isMenuVisiable = false;
  PageController pageController;

  bool isLoading = false;
  double topSafeHeight = .0;
  List<Chapters> chaptersList = [];
  List<Chapter> chapterL = new List();
  Chapter preChapter;
  Chapter currentChapter;
  Chapter nextChapter;
  ReadBookDbProvider readBookDbProvider = new ReadBookDbProvider();

  //缓存10章
  int catchChapterIndex = 9;
  int pointNextCatch = 0;

  List<Chapter> catchChaptersList = [];

  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    // TODO: implement State
    Future.delayed(Duration(seconds: 0), () async {
      await setup();
    });

    //菜单栏监听
    stream = Code.eventBus.on<ReaderMenuEvent>().listen((event) {
      var data = event.data;
      switch (event.readerMenuType) {
        //目录
        case ReaderMenuType.catlog:
          currentChapterIndex = int.parse(data.toString());
          Future.delayed(Duration(seconds: 0), () async {
           await resetContent(data, Todo.toOther, PageJumpType.firstPage);
           pageController =
               PageController(initialPage: pageIndex, keepPage: false);
           pageController.addListener(onScroll);
          });
          break;
        //字体大小
        case ReaderMenuType.fontsize:
          SettingManager.getInstance().saveFontSize(int.parse(data.toString()));
          Future.delayed(Duration(seconds: 0), () async {
            await resetContent(
                currentChapterIndex, Todo.toNext, PageJumpType.stay);
          });
          pageController =
              PageController(initialPage: pageIndex, keepPage: false);
          pageController.addListener(onScroll);
          break;

        //行间距
        case ReaderMenuType.rowSpacing:
          SettingManager.getInstance()
              .saveLetterHeight(double.parse(data.toString()));
          Future.delayed(Duration(seconds: 0), () async {
            await resetContent(
                currentChapterIndex, Todo.toNext, PageJumpType.stay);
          });
          pageController =
              PageController(initialPage: pageIndex, keepPage: false);
          pageController.addListener(onScroll);
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    print('退出阅读');
    // TODO: implement dispose
    Future.delayed(Duration(seconds: 0), () async {
      await readBookDbProvider
          .insert(new ReadBooks(widget.bookId, currentChapterIndex, pageIndex));
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child:
                  Image.asset('static/images/read_bg.png', fit: BoxFit.cover)),
          buildPageView(),
          buildMenu(),
        ],
      ),
    );
  }

  void setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    topSafeHeight = ScreenUtil2.topSafeHeight;
    //先获取所要章节的链接
    Data data = await dioGetAToc(widget.bookId, "chapters");
    if (data.result && data.data.toString().length > 0) {
      MixToc mixToc = data.data;
      chaptersList = mixToc.chapters;
    }

    //从数据库中查询阅读记录
    ReadBooks readBooks = await readBookDbProvider.getReadBooks(widget.bookId);
    if (readBooks == null) {
      readBooks = new ReadBooks(widget.bookId, 0, 0);
      await readBookDbProvider.insert(readBooks);
    }
    currentChapterIndex = readBooks.chapterIndex;
    pageIndex = readBooks.pageIndex;
    pageController = PageController(initialPage: pageIndex, keepPage: true);
    pageController.addListener(onScroll);
    await resetContent(currentChapterIndex, Todo.toNext, PageJumpType.stay);

    //第一次必须加载上一章节
    if (currentChapterIndex != 0) {
      if(preChapter == null){
        preChapter = await fetchChapter(currentChapterIndex - 1);
      }
      pageController.jumpToPage(
          (preChapter != null ? preChapter.pageCount : 0) + pageIndex);
    }
  }

  //获取内容
  resetContent(
    int currentChapterIndex,
    Todo todo,
    PageJumpType jumpType,
  ) async {
    if (todo == Todo.toNext) {
        preChapter = currentChapter;

      if (nextChapter != null && jumpType != PageJumpType.stay) {
        currentChapter = nextChapter;
        chapterL.add(currentChapter);
      } else {
        currentChapter = await fetchChapter(currentChapterIndex);
        chapterL.add(currentChapter);
      }
      if (chaptersList.length >= (currentChapterIndex + 1)) {
        nextChapter = await fetchChapter(currentChapterIndex + 1);
      } else {
        nextChapter = null;
      }
    } else if (todo == Todo.toPre) {
      if (preChapter != null) {
        nextChapter = currentChapter;
        currentChapter = preChapter;
        if (currentChapterIndex > 0) {
          preChapter = await fetchChapter(currentChapterIndex - 1);
        } else {
          preChapter = null;
        }
      }
    } else if (todo == Todo.toOther) {
      if (currentChapterIndex != 0) {
        preChapter = await fetchChapter(currentChapterIndex - 1);
      } else {
        preChapter = null;
      }
      currentChapter = await fetchChapter(currentChapterIndex);
      if (chaptersList.length > (currentChapterIndex + 1)) {
        nextChapter = await fetchChapter(currentChapterIndex + 1);
      } else {
        nextChapter = null;
      }
    }

    if (jumpType == PageJumpType.firstPage) {
      pageIndex = 0;
    } else if (jumpType == PageJumpType.lastPage) {
      pageIndex = currentChapter.pageCount - 1;
    }
    if (jumpType != PageJumpType.stay) {
      pageController.jumpToPage(
          (preChapter != null ? preChapter.pageCount : 0) + pageIndex);
    } else {
//      pageController.jumpToPage(
//          (preChapter != null ? preChapter.pageCount : 0) + pageIndex);
    }

    setState(() {});
  }

  Future<Chapter> fetchChapter(int index) async {
    Chapter article;
    String body =
        DownloadManager.getChapter(widget.bookId, currentChapterIndex);
    if (body.isNotEmpty) {
      print('从缓存中读取第${currentChapterIndex}章');
      article = new Chapter('', '', '');
      article.title = chaptersList[index].title;
      article.body = body;
    } else {
      Data data = await dioGetChapterBody(
          chaptersList[index].link, chaptersList[index].title);
      if (data.data == null) {
        return null;
      }
      article = data.data;
    }

    var contentHeight = ScreenUtil.screenHeight -
        topSafeHeight -
        ReaderUtils.topOffset -
        ScreenUtil2.bottomSafeHeight -
        ReaderUtils.bottomOffset -
        50;
    var contentWidth = ScreenUtil.screenWidth - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(
        StringUtils.formatContent(article.body),
        contentHeight,
        contentWidth,
        ScreenUtil2.fixedFontSize(
            SettingManager().getReadFontSize().toDouble()));
    return article;
  }

  onScroll() async {
    var page = pageController.offset / ScreenUtil2.width;

    var nextArtilePage = currentChapter.pageCount +
        (preChapter != null ? preChapter.pageCount : 0);
    if (page >= nextArtilePage) {
      setState(() {
        currentChapterIndex++;
      });
      print('到达下个章节了' + currentChapterIndex.toString());

      await resetContent(
          currentChapterIndex, Todo.toNext, PageJumpType.firstPage);
//      pageController.jumpToPage(preChapter.pageCount);
      setState(() {});
    }
    if (preChapter != null && page <= preChapter.pageCount - 1) {
      setState(() {
        currentChapterIndex--;
      });
      print('到达上个章节了' + currentChapterIndex.toString());
      await resetContent(
          currentChapterIndex, Todo.toPre, PageJumpType.lastPage);

//      pageController.jumpToPage(currentChapter.pageCount -1);
      setState(() {});
    }
  }

  buildPageView() {
    if (currentChapter == null) {
      return Container();
    }

    int itemCount = (preChapter != null ? preChapter.pageCount : 0) +
        currentChapter.pageCount +
        (nextChapter != null ? nextChapter.pageCount : 0);
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  fetchPreviousChapter(int index) async {
    if (preChapter != null || isLoading || index < 0) {
      return;
    }
    isLoading = true;
    preChapter = chapterL[index];
    pageController.jumpToPage(preChapter.pageCount + pageIndex);
    isLoading = false;
    setState(() {});
  }

  Widget buildPage(BuildContext context, int index) {
    var page = index - (preChapter != null ? preChapter.pageCount : 0);
    var article;
    if (page >= this.currentChapter.pageCount) {
      // 到达下一章了
      article = nextChapter;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preChapter;
      page = preChapter.pageCount - 1;
    } else {
      article = this.currentChapter;
    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        onTap(details.globalPosition);
      },
      child: ReaderView(
          article: article, page: page, topSafeHeight: topSafeHeight,bookId: widget.bookId,),
    );
  }

  fetchNextChapter(int index) async {
    isLoading = true;
    Data data = await dioGetChapterBody(
        chaptersList[index].link, chaptersList[index].title);
    if (data.result && data.data.toString().length > 0) {
      if (nextChapter != null) {
        return;
      }
      nextChapter = data.data;
      isLoading = false;
      setState(() {});
    }
  }

  onPageChanged(int index) {
    var page = index - (preChapter != null ? preChapter.pageCount : 0);
    if (page < currentChapter.pageCount && page >= 0) {
      setState(() {
        pageIndex = page;
      });
    }
  }

  onTap(Offset position) async {
    double xRate = position.dx / ScreenUtil2.width;
    if (xRate > 0.33 && xRate < 0.66) {
      if (!isMenuVisiable) {
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        setState(() {
          isMenuVisiable = true;
        });
      }
    } else if (xRate >= 0.66) {
      nextPage();
    } else if (xRate <= 0.33) {
      previousPage();
    }
  }

  nextPage() {
    if (pageIndex >= currentChapter.pageCount - 1 && nextChapter == null) {
      print('已经是最后一页了');
      return;
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 1), curve: Curves.linear);
  }

  previousPage() {
    if (currentChapterIndex == 0 && pageIndex == 0) {
      print('已经是第一页了');
      return;
    }
    pageController.previousPage(
        duration: Duration(milliseconds: 1), curve: Curves.linear);
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    return ReaderMenu(
      onTap: hideMenu,
      bookId: widget.bookId,
      bookTitle: widget.bookTitle,
      chaptersList: chaptersList,
      currentIndex: currentChapterIndex,
    );
  }

  hideMenu() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    setState(() {
      this.isMenuVisiable = false;
    });
  }
}
