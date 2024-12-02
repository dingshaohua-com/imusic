import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';

// 应用入口程序
void main() {
  runApp(MyApp());
}

// 根组件（root widget）
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer player = AudioPlayer();
  static const String musicPath = 'https://file.dingshaohua.com/qlx.mp3';
  // late延迟初始化的变量：主要原因是因为与 JavaScript、Python、Java不同，Dart 的 非空类型变量初始化没有默认值，
  // late bool _isPlaying;
  // late bool _isPaused;
  PlayerState? _playerState;

  // 生命周期函数，用于初始化状态，如果有需要可以写，非必须如初始化数据、设置监听器、调用异步操作等
  @override
  void initState() {
    super.initState();

    _playerState = player.state;

    // 监听状态变化
    player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
      });
    });

    // 监听状态变化
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String appTitle = '测试';
    // 使用空值安全操作符防止 _playerState 为 null 时出现错误
    String playerStateText = _playerState?.toString().split('.').last ?? '未知状态';
    return MaterialApp(
      // 风格类型的根组件
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.red,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 让子组件从顶部开始排列
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 150), // 在四个方向上添加 20 的外部间距
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/defaut-music.jpg',
                        width: 200, // 设置图片的宽度
                        height: 200, // 设置图片的高度
                      ))),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('歌手: '), Text('周杰伦')],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    '七里香: $playerStateText',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 160),
                  width: screenWidth * 0.8,
                  height: 2,
                  color: Colors.grey[200]),
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: screenWidth * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 内部元素水平居中
                  children: [
                    SvgPicture.asset(
                      'assets/img/player-skip-back.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 60),
                    GestureDetector(
                        onTap: () {
                          // 处理点击事件
                          print('SVG clicked!');
                          if(_playerState == PlayerState.stopped){
                            player.play(UrlSource(musicPath));
                          }else{
                            player.stop();
                          }

                        },
                        child: SvgPicture.asset(
                          _playerState == PlayerState.stopped?'assets/img/player-play.svg':'assets/img/player-pause.svg',
                          semanticsLabel: 'Dart Logo',
                          width: 20,
                          height: 20,
                        )),
                    SizedBox(width: 60),
                    SvgPicture.asset(
                      'assets/img/player-skip-forward.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
