import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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

var _routes = <String>[
  '/song',
  '/home',
  '/about',
];

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: _barItems,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
          context.go(_routes.elementAt(index));
        },
      ),
      // 內容由外面來決定
      body: widget.child,
    );
  }
}
