import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zwt_life_flutter_app/common/event/ChatEvent.dart';
import 'package:zwt_life_flutter_app/common/event/ChatImageEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/ToastUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageList.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatMessageListItem.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatSwipperGrid.dart';
import 'package:zwt_life_flutter_app/common/widgets/messagewidget/ChatUser.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/MyOutLineButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

var currentUserEmail;
var _scaffoldContext;

class MessageTalkingPage extends StatefulWidget {
  static final String sName = "MessageTalkingPage";

  @override
  _MessageTalkingPage createState() {
    // TODO: implement createState
    return _MessageTalkingPage();
  }
}

class _MessageTalkingPage extends State<MessageTalkingPage>
    with SingleTickerProviderStateMixin {
  //输入框控制
  final TextEditingController _textEditingController =
      new TextEditingController();

  StreamSubscription _recorderSubscription, _playerSubscription;

  //发送完消息 需要下拉到最底部
  final ScrollController _scrollController = new ScrollController();

  //输入？
  bool _isComposingMessage = false;

  //不显示麦克
  bool _isMicroPhone = false;

  //用户数据
  List<ChatUser> listChat = [];

  //订阅
  EventBus eventBus = new EventBus();

  //输入框焦点变化
  FocusNode nodeOne = FocusNode();

  //录音
  FlutterSound flutterSound;

  //开始录音？
  bool isStartRecoder = false;
  String timeRecorder;

  //录音路径
  String pathRecorder;

  //图片路径
  File _image;
  bool _notShowBottomConat = true;

  //监听图片
  StreamSubscription streamImage;

  getDataList() {
    listChat.add(new ChatUser(
        userId: "1076820548",
        userName: "明识",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766000,
        chatData: ChatData(text: "你是？？？", imageUrl: "")));
    listChat.add(new ChatUser(
        userId: "1076820547",
        userName: "明识2",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766058,
        chatData: ChatData(text: "我叫明识2", imageUrl: "")));
    listChat.add(new ChatUser(
        userId: "1076820548",
        userName: "明识",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766111,
        chatData: ChatData(text: "哦哦，我叫明识，萨瓦迪卡", imageUrl: "")));
    listChat.sort((a, b) {
      if (a.time > b.time) {
        return -1;
      } else {
        return 1;
      }
    });
  }

  @override
  void initState() {
    initSubscription();
    getDataList();
    initScroll();
    flutterSound = new FlutterSound();
    nodeOne.addListener(() {
      if (nodeOne.hasFocus) {
        if (!_notShowBottomConat) {
          setState(() {
            _notShowBottomConat = !_notShowBottomConat;
          });
        }
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.5,
          title: Text(
            "老杨",
            style: TextStyle(
                fontSize: GlobalConstant.middleTextWhiteSize,
                fontWeight: FontWeight.w600),
          ),
//          backgroundColor: GlobalColors.ChatThemeColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {},
            )
          ],
        ),
        preferredSize: Size.fromHeight(ScreenUtil.designTopBarHeight),
      ),
      body: Container(
//        color: GlobalColors.ChatBgColor,
        child: Column(
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                onTap: () => hideKey(),
                onPanDown: (DragDownDetails e) {
                  //隐藏输入框
                  hideKey();
                },
                child: Scrollbar(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      //return true; //放开此行注释后，进度条将失效
                    },
                    child: ChatMessageList(
                      listData: listChat,
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        return ChatMessageListItem(
                          animation: animation,
                          chatUser: listChat[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            Builder(builder: (BuildContext context) {
              _scaffoldContext = context;
              return Container(
                width: 0.0,
                height: 0.0,
              );
            })
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                    top: BorderSide(
                color: Colors.grey[200],
              )))
            : null,
      ),
    );
  }

  //返回到底部的动画
  void bottomAnimation() {
    _scrollController.jumpTo(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  Widget _getDefultTextFile() {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !_isMicroPhone,
          child: Listener(
            onPointerDown: (PointerDownEvent event) => _startRecorder(),
            onPointerUp: (PointerUpEvent event) => _stopRecorder(),
            child: MyOutlineButton(
              color: GlobalColors.ChatMsgColor,
              splashColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              text: isStartRecoder ? "松开 结束" : "按住 说话",
            ),
          ),
        ),
        Offstage(
          offstage: _isMicroPhone,
          child: TextField(
            focusNode: nodeOne,
            maxLines: null,
            textInputAction: TextInputAction.send,
            controller: _textEditingController,
            onChanged: (String messageText) {
              setState(() {
                _isComposingMessage = messageText.length > 0;
              });
            },
            onSubmitted: _textMessageSubmitted,
            decoration: new InputDecoration(
                filled: true,
                fillColor: GlobalColors.ChatMsgColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                hintText: "",
                border: OutlineInputBorder()),
          ),
        )
      ],
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: GlobalColors.ChatTextColor,
        ),
        child: new Container(
          color: GlobalColors.ChatBgColor,
          child: Column(
            //列
            children: <Widget>[
              new Row(
                //行
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 4.0),
                    child: getDefaultMicButton(),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _getDefultTextFile(),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: getDefaultSendButton(),
                  ),
                ],
              ),
              Offstage(
                offstage: _notShowBottomConat,
                child: new Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),
                    ChatSwipperGrid()
                  ],
                ),
              )
            ],
          ),
        ));
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: _isComposingMessage
          ? Icon(
              Icons.send,
              color: Theme.of(context).accentColor,
              size: 30,
            )
          : Icon(
              Icons.add_circle_outline,
              size: 30.0,
            ),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : () => getShowBottom(),
    );
  }

  IconButton getDefaultMicButton() {
    return _isMicroPhone
        ? IconButton(
            icon: new Icon(
              Icons.keyboard,
              size: 30.0,
            ),
            onPressed: () async {
              setState(() {
                _isMicroPhone = false;
                showKey();
              });
            })
        : IconButton(
            icon: new Icon(
              Icons.mic,
              size: 30.0,
            ),
            onPressed: () async {
              setState(() {
                _isMicroPhone = true;
                hideKey();
              });
            });
  }

//  SoundUtils.getInstance().startRecorder(uri: "1.mp4");

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();
    if (text.length < 1) {
      return;
    }
//    hideKey();
    setState(() {
      _isComposingMessage = false;
      _sendMessage(messageText: text, imageUrl: null, voicePath: null);
      bottomAnimation();
    });
  }

  //发送消息
  void _sendMessage(
      {String messageText,
      var imageUrl,
      String voicePath,
      String timeRecorder}) {
    listChat.add(new ChatUser(
        userId: "1076820548",
        userName: "明识",
        userIconUrl:
            "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
        time: 1552876766000,
        chatData: ChatData(
            text: messageText, imageUrl: imageUrl, voicePath: voicePath)));
    Code.eventBus.fire(new ChatEvent(
        index: 0,
        chatUser: ChatUser(
            userId: "1076820548",
            userName: "明识",
            userIconUrl:
                "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1552640466&di=1052b2f2e877ead75521398a9b1f4172&src=http://img.yoyou.com/uploadfile/2017/0818/20170818095143376.jpg",
            time: 1552876766000,
            chatData: ChatData(
                text: messageText,
                imageUrl: imageUrl,
                voicePath: voicePath,
                timeRecorder: timeRecorder))));
  }

  //开始录音
  void _startRecorder() async {
    setState(() {
      isStartRecoder = true;
    });
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    String uri = appDocDirectory.path + '/' + 'df3453.m4a';
    pathRecorder = await flutterSound.startRecorder(uri);
    print('startRecorder: $pathRecorder');
    // /storage/emulated/0/default.m4a
//    /data/user/0/com.zwt.zwtlifeflutterapp/app_flutter/df.m4a
    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      setState(() {
        timeRecorder = DateFormat('mm:ss', 'en_US').format(date);
      });
    });
  }

  //停止录音
  void _stopRecorder() async {
    setState(() {
      isStartRecoder = false;
    });
    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
    _sendMessage(voicePath: pathRecorder, timeRecorder: timeRecorder);
//    _startPlayer();
  }

  //播放录音
  _startPlayer() async {
    String pathPlayer = await flutterSound.startPlayer(pathRecorder);
    print('startPlayer: $pathPlayer');
    _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
      if (e != null) {
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());

//        this.setState(() {
//          this._isPlaying = true;
//          this._playerTxt = txt.substring(0, 8);
//        });
      }
    });
  }

  //滑动监听
  void initScroll() {
    _scrollController.addListener(() {});
  }

  //隐藏键盘
  void hideKey() {
    setState(() {
      if (!_notShowBottomConat) {
        _notShowBottomConat = !_notShowBottomConat;
      }
      if (nodeOne.hasFocus) {
        nodeOne.unfocus();
      }
    });
  }

  //显示键盘
  void showKey() {
    setState(() {
      if (!_notShowBottomConat) {
        _notShowBottomConat = !_notShowBottomConat;
      }
      FocusScope.of(context).requestFocus(nodeOne);
    });
  }

  //展示底部
  Future getShowBottom() async {
    setState(() {
      if (nodeOne.hasFocus) {
        nodeOne.unfocus();
      }
      _notShowBottomConat = !_notShowBottomConat;
    });
  }

  void initSubscription() {
    streamImage = Code.eventBus.on<ChatImageEvent>().listen((event) {
      _sendMessage(imageUrl: event.image);
    });
  }
}
