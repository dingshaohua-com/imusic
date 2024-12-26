import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerBall extends StatelessWidget {
  const PlayerBall({super.key});

  @override
  Widget build(BuildContext context) {
    // String playIcon = _playerState == PlayerState.stopped ||
    //     _playerState == PlayerState.paused
    //     ? 'assets/img/player-play.svg'
    //     : 'assets/img/player-pause.svg';
    return Positioned(
        right: 0,
        left: 0,
        bottom: 0, // 控制浮动按钮的位置，确保它不会被BottomNavigationBar遮挡
        child: Center(
          child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0, color: Colors.pink),
                      color: Colors.pink, // Background color of the container
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20), // 左上角圆角
                        topRight: Radius.circular(20), // 右上角圆角
                        bottomLeft: Radius.circular(0), // 左下角圆角
                        bottomRight: Radius.circular(0), // 右下角圆角
                      ), // Round all corners with a radius of 16
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: const Text('伤心太平洋')),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // 水平方向20、垂直方向10的内边距
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Background color of the container
                      borderRadius: BorderRadius.all(Radius.circular(
                          20)), // Round all corners with a radius of 16
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/img/player-skip-back.svg",
                          semanticsLabel: 'Dart Logo',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 60),
                        SvgPicture.asset(
                          "assets/img/player-play.svg",
                          semanticsLabel: 'Dart Logo',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 60),
                        SvgPicture.asset(
                          "assets/img/player-skip-forward.svg",
                          semanticsLabel: 'Dart Logo',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    )),
              ]),
        ));
  }
}
