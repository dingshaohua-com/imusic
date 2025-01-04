import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/api/qqmusic.dart';
import '../store/player_state_notifier.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});
  @override
  SongsPageState createState() => SongsPageState();
}

class SongsPageState extends State<SongsPage> {
  late List<dynamic> topGroup; // 用于保存请求结果

  @override
  void initState() {
    super.initState();
    topGroup = []; // 初始状态
    loadData(); // 发起请求
  }

  // 异步 HTTP 请求方法
  void loadData() async {
    var res = await getSongs();
    setState(() {
      topGroup = res;
    });
  }

  void onTap(item, ref) async {
    // 创建 Player 实例，并监听状态变化
    PlayerStateNotifier playerStateNotifier =
        ref.read(playerStateProvider.notifier);
    playerStateNotifier.playOrResume(item['mid']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red, // 给 Container 设置背景色
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                loadData();
              },
              child: const Text('测试'))
        ]));
  }
}
