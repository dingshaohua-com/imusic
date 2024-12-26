import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

// 根组件（root widget）
class MyPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyPlayer> {
  AudioPlayer player = AudioPlayer();
  PlayerState? _playerState;
  Duration _duration = const Duration(minutes: 0, seconds: 0); // 总时长
  Duration _position = const Duration(minutes: 0, seconds: 0); // 当前进度

  // 生命周期函数，用于初始化状态，如果有需要可以写，非必须如初始化数据、设置监听器、调用异步操作等
  @override
  void initState() {
    super.initState();

    // 从 player 中对变量初始化
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value!;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value!;
          }),
        );

    // ---监听状态变化 _initStreams start---
    player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });
    player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );
    player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });
    player.onPlayerStateChanged.listen((state) {
      setState(() => _playerState = state);
    });
    // ---监听状态变化 _initStreams end---
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
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const String appTitle = 'IMusic';
    String playIcon = _playerState == PlayerState.stopped ||
            _playerState == PlayerState.paused
        ? 'assets/img/player-play.svg'
        : 'assets/img/player-pause.svg';
    String positionTemp = DateFormat("mm:ss").format(DateTime(0).add(_position));
    String durationTemp = DateFormat("mm:ss").format(DateTime(0).add(_duration));
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
            backgroundColor: Colors.red
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 让子组件从顶部开始排列
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 100), // 在四个方向上添加 20 的外部间距
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/img/defaut-music.jpg',
                        width: 220, // 设置图片的宽度
                        height: 220, // 设置图片的高度
                      ))),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Text('歌手: '), const Text('周杰伦'), const SizedBox(width: 10), const Text('|'), const SizedBox(width: 10), Text('$positionTemp / $durationTemp')],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: const Text(
                    '七里香',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 60),
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
                          // 处理点击事件
                          if (_playerState == PlayerState.stopped) {
                            if (player.source == null) {
                              print('初始化了');
                              await _init();
                            }
                            print('播放了1');
                            await _play();
                          } else if (_playerState == PlayerState.paused) {
                            print('播放了2');
                            await _play();
                          } else if (_playerState == PlayerState.playing) {
                            await _pause();
                            print('暂停了');
                          } else {
                            print('点击时事件了，但是都没匹配');
                          }
                        },
                        child: SvgPicture.asset(
                          playIcon,
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
