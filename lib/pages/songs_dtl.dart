import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imusic/api/qqmusic.dart';
import '../store/player_state_notifier.dart';

class SongsDtlPage extends StatefulWidget {
  final String id;
  const SongsDtlPage({super.key, required this.id});
  @override
  SongsDtlPageState createState() => SongsDtlPageState();
}

class SongsDtlPageState extends State<SongsDtlPage> {
  final List<dynamic> _items = []; // 数据列表
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  bool _isLoadingMore = false; // 上拉加载状态

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // 初始加载数据
    _scrollController.addListener(() {
      // 检测是否滚动到底部
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        _loadMoreData();
      }
    });
  }

  // 下拉刷新
  Future<void> _refreshData() async {
    setState(() {
      _page = 0; // 重置页码
      _items.clear(); // 清空旧数据
    });
    await _loadInitialData(); // 重新加载数据
  }

  // 加载初始数据
  Future<void> _loadInitialData() async {
    List<dynamic> newData = await getSongsDtl(_page, widget.id);
    setState(() {
      _items.addAll(newData);
    });
  }

  // 上拉加载更多
  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    var newData = await getSongsDtl(_page + 1, widget.id);
    setState(() {
      _page++; // 更新页码
      _items.addAll(newData);
      _isLoadingMore = false;
    });
  }

  void onTap(item, ref) async {
    // // 创建 Player 实例，并监听状态变化
    // PlayerStateNotifier playerStateNotifier =
    //     ref.read(playerStateProvider.notifier);
    // playerStateNotifier.playOrResume(item['mid']);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
            const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();  // 返回按钮点击事件
              },
            ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0), // 左右和下边的边距
              child: ListView.builder(
                  itemCount: _items.isNotEmpty ? 20 : 0, // 遍历数组的长度
                  itemBuilder: (context, index) {
                    final item = _items[index]; // 获取数组中的元素
                    return ListTile(
                        // leading: CircleAvatar(
                        //   backgroundImage: NetworkImage(item['pic']!), // 图片加载
                        // ),
                        title: Text(item['title']), // 显示 name 字段
                        subtitle: Text(item['name']),
                        onTap: () {
                          print('点击了');
                          // onTap(item, ref);
                        });
                  })),
        ));
  }
}
