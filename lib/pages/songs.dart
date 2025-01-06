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
  int page = 1;

  @override
  void initState() {
    super.initState();
    topGroup = []; // 初始状态
    loadData(); // 发起请求
  }

  // 异步 HTTP 请求方法
  void loadData() async {
    var res = await getSongs(page);
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
    print("--------------");
    print(topGroup);
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Wrap(
                  alignment: WrapAlignment.center, // 水平居中
                  runAlignment: WrapAlignment.center, // 让每行中的元素也居中
                  spacing: 20.0, // 水平方向的间距
                  runSpacing: 30.0, // 垂直方向的间距
                  children: List.generate(topGroup.length, (index) {
                    var item = topGroup[index];
                    return SizedBox(
                      width: 150, // 每个子项的宽度，Wrap 会根据这个宽度换行
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              item['imgurl'],
                              fit: BoxFit.cover,
                              width: 150, // 设置图片宽度，确保宽高比一致
                            ),
                          ),
                          Text(
                            item['dissname'],
                            style: const TextStyle(fontSize: 14),
                            // overflow: TextOverflow.ellipsis,
                            // textAlign: TextAlign.center, // 文本居中
                          ),
                        ],
                      ),
                    );
                  }),
                )
            )
        )
    );
  }
}
