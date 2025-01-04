import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imusic/pages/home.dart';
import 'package:imusic/pages/about.dart';
import 'package:imusic/components/player_ball.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/pages/songs.dart';

/*
* 定义标签栏和标签页
* */
const _widgetOptions = <Widget>[SongsPage(), HomePage(), AboutPage()];
var _barItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: SvgPicture.asset("assets/img/bottom_bar/top.svg", width: 30, height: 30),
    label: '排行',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset("assets/img/bottom_bar/songs.svg", width: 30, height: 30),
    label: '歌单',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset("assets/img/bottom_bar/me.svg", width: 30, height: 30),
    label: '我的',
  ),
];

/*
* 入口函数
* */
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/*
* 根组件
* */
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(),
            body: Stack(children: [
              _widgetOptions.elementAt(currentIndex),
              const PlayerBall()
            ]),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex, onTap: onTap, items: _barItems)));
  }
}
