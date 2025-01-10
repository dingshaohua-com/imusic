import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imusic/components/player_ball.dart';


/*
* 定义标签栏和标签页
* */
var _barItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/img/bottom_bar/songs.svg",
          width: 30, height: 30),
      label: '歌单'),
  BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/img/bottom_bar/top.svg",
          width: 30, height: 30),
      label: '排行'),
  BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/img/bottom_bar/me.svg",
          width: 30, height: 30),
      label: '我的'),
];

// 定义ScaffoldWithNavBar （底部导航和页面展示框架）
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    this.showNavBar=false,
    Key? key,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;
  final bool showNavBar;

  @override
  Widget build(context) {

    // final location = GoRouter.of(context).location;
    return Scaffold(
      body: Stack(children: [navigationShell, const PlayerBall()]),
      bottomNavigationBar: showNavBar?BottomNavigationBar(
        items: _barItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ):null,
    );
  }

  void _onTap(context, index) {
    var initialLocation = index == navigationShell.currentIndex;
    navigationShell.goBranch(index, initialLocation: initialLocation);
  }
}
