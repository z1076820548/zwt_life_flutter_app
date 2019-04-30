import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/model/Search.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/public.dart';

class SearchResultListWidget extends StatelessWidget {
  final List<TagBookBean> list;
  final ValueChanged<String> onItemTap;
  final VoidCallback getNextPage;

  SearchResultListWidget(this.list, {this.onItemTap, this.getNextPage});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return list.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int i) {
              return returnItem(list[i]);
            });
  }

  returnItem(TagBookBean book) {
    return Material(
      child: Ink(
        child: InkWell(
          onTap: () {
            onItemTap(book.id);
          },
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: ExtendedImage.network(
                        (Constant.IMG_BASE_URL + book.cover),
                        height: ScreenUtil.getInstance().L(50),
                        fit: BoxFit.fitHeight,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        cache: true,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                book.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(16)),
                              ),
                            ),
                            Text(
                              book.author + '  |  ' + (book.cat == null ? (book.minorCate == null ? "null":book.minorCate):book.cat),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil.getInstance().setSp(12)),
                            ),
                            Text(
                              book.shortIntro,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil.getInstance().setSp(12)),
                            ),
                            Text(
                              book.latelyFollower.toString() +
                                  " 人在追  |  " +
                                  book.retentionRatio.toString() +
                                  "% 读者留存率",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: ScreenUtil.getInstance().setSp(12)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                indent: 20,
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
