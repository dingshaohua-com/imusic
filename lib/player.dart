import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';

// 根组件（root widget）
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer player = AudioPlayer();
  PlayerState? _playerState;
  Duration? _position;

  // 生命周期函数，用于初始化状态，如果有需要可以写，非必须如初始化数据、设置监听器、调用异步操作等
  @override
  void initState() {
    super.initState();

    _playerState = player.state;

    // 监听状态变化
    player.onPlayerComplete.listen((event) {
      _playerState = PlayerState.stopped;
    });

    // 监听状态变化
    player.onPlayerStateChanged.listen((state) {
      _playerState = state;
    });
  }

  // 点击播放相关按钮

  Future<void> _init(
      {String url = 'https://file.dingshaohua.com/qlx.mp3'}) async {
    await player.setSource(UrlSource(url));
    await player.resume();
  }

//  如果音频已经暂停，resume() 会从暂停的位置继续播放。
//  •	如果音频已经在播放或者停止状态，调用 resume() 可能不会有任何效果，或者会抛出异
  Future<void> _play() async {
    // await player.resume();
    await player.resume();
    _playerState = PlayerState.playing;
  }

  Future<void> _pause() async {
    await player.pause();
    _playerState = PlayerState.paused;
  }

  Future<void> _stop() async {
    await player.stop();
    _playerState = PlayerState.stopped;
    _position = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const String appTitle = 'IMusic';
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
                    '七里香: $_playerState',
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
                        onTap: () async {
                          print('点击时事件了');
                          // 处理点击事件

                          if (_playerState == PlayerState.stopped) {
                            // player.play(UrlSource(musicPath));
                            print('------------');

                            if (player.source==null) {
                              print('初始化了');
                              await _init();
                            }
                            print('播放了1');
                            _play();
                          } else if (_playerState == PlayerState.paused) {
                            print('播放了2');
                            _play();
                          } else if (_playerState == PlayerState.playing) {
                            _pause();
                            print('暂停了');
                          }else{
                            print('点击时事件了，但是都没匹配');
                          }
                        },
                        child: SvgPicture.asset(
                          _playerState == PlayerState.stopped ? 'assets/img/player-play.svg':'assets/img/player-pause.svg' ,
                          semanticsLabel: 'Dart Logo',
                          width: 40,
                          height: 40,
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
