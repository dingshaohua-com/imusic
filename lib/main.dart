import 'package:flutter/material.dart';
import 'package:imusic/pages/home.dart';
import 'package:imusic/pages/about.dart';
import 'package:imusic/components/player.dart';
import 'package:imusic/components/player_ball.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* 定义标签栏和标签页
* */
const _widgetOptions = <Widget>[HomePage(), AboutPage()];
const _barItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home, size: 36),
    label: '首页',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.account_circle, size: 36),
    label: '我的',
  ),
];

/*
* 入口函数
* */
void main() {
  Player player = Player.getInstance();
  player.subscribe();

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
        const PlayerBall(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex, onTap: onTap, items: _barItems),
    ));
  }
}
