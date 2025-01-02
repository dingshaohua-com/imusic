import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

import '../store/player_state_notifier.dart';
import 'package:intl/intl.dart';
import 'package:imusic/utils/common.dart';

class PlayerFull extends ConsumerWidget {
  const PlayerFull({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("歌曲时长");
    // print(duration);
    // print("歌曲时长 end");
    final playerState = ref.watch(playerStateProvider);
    print(playerState.status);
    String playIcon = playerState.status == PlayerState.playing
        ? 'assets/img/player-play.svg'
        : 'assets/img/player-pause.svg';
    return Container(
        color: Colors.limeAccent,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: [
            Container(
                // 在四个方向上添加 20 的外部间距
                child: Align(
                    alignment: Alignment.center,
                    child:Image.network(playerState.coverUrl)
                    // Image.asset(
                    //   'assets/img/defaut-music.jpg',
                    //   width: 220, // 设置图片的宽度
                    //   height: 220, // 设置图片的高度
                    // )
                )
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('歌手: '),
                    Text(playerState.author),
                    const SizedBox(width: 10),
                    const Text('|'),
                    const SizedBox(width: 10),
                    Text('${printDuration(playerState.position)} / ${printDuration(playerState.duration)}')
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  playerState.songName,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            print(1111111);
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/img/down.svg',
                              width: 30, height: 30)),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 2,
                      color: Colors.grey[200]),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
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
                        // if (_playerState == PlayerState.stopped) {
                        //   if (player.source == null) {
                        //     print('初始化了');
                        //     await _init();
                        //   }
                        //   print('播放了1');
                        //   await _play();
                        // } else if (_playerState == PlayerState.paused) {
                        //   print('播放了2');
                        //   await _play();
                        // } else if (_playerState == PlayerState.playing) {
                        //   await _pause();
                        //   print('暂停了');
                        // } else {
                        //   print('点击时事件了，但是都没匹配');
                        // }
                      },
                      child: SvgPicture.asset(
                        playIcon,
                        semanticsLabel: 'Dart Logo',
                        width: 40,
                        height: 40,
                      )),
                  SizedBox(width: 60),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/img/player-skip-forward.svg',
                      semanticsLabel: 'Dart Logo',
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }
}
