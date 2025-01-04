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
    print(22222);
    print(res);
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
    print(3333);
    print(topGroup);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.limeAccent, // 给 Container 设置背景色
      child: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(topGroup.length, (index) {
          var item = topGroup[index];
          return Center(
            child: Column(
              children: [
                Image.network( item['cover_url_small'], width: 100, height: 100,),
                Text(
                  item['title']
                ),
              ],
            )
          );
        }),
      ),
    );
  }
}
