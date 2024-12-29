import 'package:flutter/material.dart';
import 'package:imusic/api/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/store/index.dart';

import '../model/player_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Player player = Player.getInstance();

  late List<dynamic> topGroup; // 用于保存请求结果

  @override
  void initState() {
    super.initState();
    topGroup = []; // 初始状态
    loadData(); // 发起请求
  }

  // 异步 HTTP 请求方法
  void loadData() async {
    var res = await getHotMusic();
    setState(() {
      topGroup = res;
    });
  }

  void onTap(item, ref) async {
    var mid = item['mid'];
    var music = await getMusic(mid);
    PlayerState playerState = ref.read(playerProvider.notifier).state;
    ref.read(playerProvider.notifier).state = playerState.copyWith(
        status: 'playing', song: playerState.song.copyWith(url: music['musicUrl'], name: music['title'], pic:music['pic']));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ListView.builder(
          itemCount: topGroup.isNotEmpty ? 20 : 0, // 遍历数组的长度
          itemBuilder: (context, index) {
            final item = topGroup[index]; // 获取数组中的元素
            return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['pic']!), // 图片加载
                ),
                title: Text(item['title']), // 显示 name 字段
                subtitle: Text(item['author']),
                onTap: () {
                  print('点击了');
                  onTap(item, ref);
                });
          });
    });
  }
}
