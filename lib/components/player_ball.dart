import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/store/index.dart';
import 'package:imusic/utils/player.dart';
import 'package:marquee/marquee.dart';

Player player = Player.getInstance();

class PlayerBall extends ConsumerWidget {
  const PlayerBall({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);

    print(playerState);

    if (playerState.status == 'playing') {
      player.play(playerState.song.url);
    }

    String playIcon = playerState.status == 'stop'
        ? 'assets/img/player-play.svg'
        : 'assets/img/player-pause.svg';
    return Positioned(
        right: 0,
        left: 0,
        bottom: 0, // 控制浮动按钮的位置，确保它不会被BottomNavigationBar遮挡
        child: Center(
          child: Column(children: [
            Container(
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(width: 0, color: Colors.deepOrangeAccent),
                  color: Colors.deepOrangeAccent, // Background color of the container
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30), // 左上角圆角
                    topRight: Radius.circular(30), // 右上角圆角
                    bottomLeft: Radius.circular(0), // 左下角圆角
                    bottomRight: Radius.circular(0), // 右下角圆角
                  ), // Round all corners with a radius of 16
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      playerState.song.pic.isEmpty
                          ? SvgPicture.asset('assets/img/music.svg', width: 30, height: 30)
                          : Image.network(playerState.song.pic, width: 30, height: 30),

                      Container(
                        margin: const EdgeInsets.only(left: 18), // 设置外边距
                        width: 80, // 设置宽度
                        height: 30,

                        child: Marquee(
                          text: playerState.song.name,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                          blankSpace: 20, // 跑马灯前后留白
                          velocity: 10, // 滚动速度
                          pauseAfterRound: const Duration(seconds: 2), // 滚动停止时间
                        ),
                      )
                      // Text(playerState.song.name)
                    ])),
            Container(
                width: 300,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // 水平方向20、垂直方向10的内边距
                decoration: const BoxDecoration(
                  color: Colors.blue, // Background color of the container
                  borderRadius: BorderRadius.all(Radius.circular(
                      30)), // Round all corners with a radius of 16
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/img/player-skip-back.svg",
                      semanticsLabel: 'Dart Logo',
                      width: 25,
                      height: 25,
                        colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn )
                    ),
                    SvgPicture.asset(
                      playIcon,
                      semanticsLabel: 'Dart Logo',
                      width: 25,
                      height: 25,
                        colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn )
                    ),
                    SvgPicture.asset(
                      "assets/img/player-skip-forward.svg",
                      semanticsLabel: 'Dart Logo',
                      width: 25,
                      height: 25,
                      colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn )
                    ),
                  ],
                )),
          ]),
        ));
  }
}
