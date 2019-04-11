import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderPageAgent.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ReaderView.dart';
import 'package:zwt_life_flutter_app/public.dart';

class ReadBookPage extends StatefulWidget {
  final String bookId;
  static final String sName = "ReadBook";

  const ReadBookPage({Key key, this.bookId}) : super(key: key);

  @override
  _ReadBookPageState createState() {
    // TODO: implement createState
    return _ReadBookPageState();
  }
}

class _ReadBookPageState extends State<ReadBookPage> with RouteAware {
  // 是否开始阅读章节
  bool startRead = false;

  int pageIndex = 0;
  int currentChapterIndex = 0;
  bool isMenuVisiable = false;
  PageController pageController = PageController(keepPage: false);
  bool isLoading = false;
  double topSafeHeight = .0;
  List<Chapters> chaptersList = [];
  List<Chapter> chapterL = [];
  Chapter preChapter;
  Chapter currentChapter;
  Chapter nextChapter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      await setup();
    });
    pageController.addListener(onScroll);
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
//                buildMenu(),
        ],
      ),
    );
  }

  void setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    topSafeHeight = ScreenUtil2.topSafeHeight;

    //先获取所要章节的链接
    Data data = await dioGetAToc(widget.bookId, "chapters");
    if (data.result && data.data.toString().length > 0) {
      MixToc mixToc = data.data;
      chaptersList = mixToc.chapters;
    }

    await resetContent(currentChapterIndex);
  }

  resetContent(int currentChapterIndex) async {
    currentChapter = await fetchChapter(currentChapterIndex);
    if (currentChapterIndex > 0) {
      preChapter = await fetchChapter(currentChapterIndex - 1);
    } else {
      preChapter = null;
    }
    if (chaptersList.length >= (currentChapterIndex + 1)) {
      nextChapter = await fetchChapter(currentChapterIndex + 1);
    } else {
      nextChapter = null;
    }
    setState(() {});
  }

  Future<Chapter> fetchChapter(int index) async {
    Data data = await dioGetChapterBody(
        chaptersList[index].link, chaptersList[index].title);
    if (data.data == null) {
      return null;
    }
    Chapter article = data.data;
    var contentHeight = ScreenUtil.screenHeight - topSafeHeight -
        ReaderUtils.topOffset - ScreenUtil2.bottomSafeHeight - ReaderUtils.bottomOffset - 20;
    var contentWidth = ScreenUtil.screenWidth - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(
        StringUtils.formatContent(article.body),
        contentHeight,
        contentWidth,
        ScreenUtil2.fixedFontSize(SettingManager().getReadFontSize().toDouble()));
    return article;
  }

  onScroll() {
    var page = pageController.offset / ScreenUtil2.width;

    var nextArtilePage = currentChapter.pageCount +
        (preChapter != null ? preChapter.pageCount : 0);
    if (page >= nextArtilePage) {
      print('到达下个章节了');
      currentChapterIndex++;
      preChapter = currentChapter;
      currentChapter = nextChapter;
      nextChapter = null;
      pageIndex = 0;
      pageController.jumpToPage(preChapter.pageCount);
      fetchNextChapter(currentChapterIndex + 1);
      setState(() {});
    }
    if (preChapter != null && page <= preChapter.pageCount - 1) {
      currentChapterIndex--;
      print('到达上个章节了');
      nextChapter = currentChapter;
      currentChapter = preChapter;
      preChapter = null;
      pageIndex = currentChapter.pageCount - 1;
      pageController.jumpToPage(currentChapter.pageCount - 1);
      fetchPreviousChapter(currentChapterIndex - 1);
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
          article: article, page: page, topSafeHeight: topSafeHeight),
    );
  }

  fetchNextChapter(int index) async {
    Data data2 = await dioGetChapterBody(
        chaptersList[index].link, chaptersList[index].title);
    if (data2.result && data2.data.toString().length > 0) {
      chapterL.add(data2.data);
    }
    if (nextChapter != null || isLoading) {
      return;
    }
    isLoading = true;
    nextChapter = chapterL[index];
    isLoading = false;
    setState(() {});
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
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
  }

  nextPage() {
    if (pageIndex >= currentChapter.pageCount - 1) {
      return;
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 0), curve: Curves.linear);
  }

  previousPage() {
    if (pageIndex == 0) {
      return;
    }
    pageController.previousPage(
        duration: Duration(milliseconds: 0), curve: Curves.linear);
  }
}
