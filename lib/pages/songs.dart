import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:imusic/api/qqmusic.dart';
import 'package:imusic/components/scaffold_bar.dart';
import '../store/player_state_notifier.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});
  @override
  SongsPageState createState() => SongsPageState();
}

class SongsPageState extends State<SongsPage> {
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
    List<dynamic> newData = await getSongs(_page);
    setState(() {
      _items.addAll(newData);
    });
  }

  // 上拉加载更多
  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    var newData = await getSongs(_page + 1);
    setState(() {
      _page++; // 更新页码
      _items.addAll(newData);
      _isLoadingMore = false;
    });
  }

  void onTap(item, ref) async {
    // 创建 Player 实例，并监听状态变化
    PlayerStateNotifier playerStateNotifier =
        ref.read(playerStateProvider.notifier);
    playerStateNotifier.playOrResume(item['mid']);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0), // 左右和下边的边距
        child: GridView.builder(
          controller: _scrollController, // 滚动监听
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0, // 每个子项的最大宽度
            crossAxisSpacing: 20.0, // 列之间的间距
            mainAxisSpacing: 20.0, // 行之间的间距
            childAspectRatio: 0.75, // 调整宽高比，适配文字内容
          ),
          itemCount: _items.length + 1, // 数据数量加上加载指示器
          itemBuilder: (context, index) {
            if (index == _items.length) {
              // 底部加载指示器
              return _isLoadingMore
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }
            var item = _items[index];
            return InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // 图片圆角
                      child: Image.network(
                        item['imgurl'], // 图片 URL
                        fit: BoxFit.cover, // 填充模式
                      ),
                    ),
                    const SizedBox(height: 8), // 图片和文字之间的间距
                    SizedBox(
                      width: 150, // 固定宽度，确保文字宽度与图片一致
                      child: Text(
                        item['dissname'], // 文本内容
                        style: const TextStyle(fontSize: 14), // 文本样式
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  context.go('/songs/songs_dtl?id=${item['dissid']}');
                });
          },
        ),
      ),
    );
  }
}
