import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/qqmusic.dart';
import 'dart:convert';
import '../store/player_state_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<TopPage> {
  final List<dynamic> _items = []; // 数据列表
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  bool _isLoadingMore = false; // 上拉加载状态

  @override
  void initState() {
    super.initState();
    initHandler();
  }

  initHandler() async {
    final String? topCacheString = await asyncPrefs.getString('top');
    if (topCacheString != null) {
      // 如果有缓存 则第一页走缓存，减少用户等待时长，下拉刷新再让他更新
      List<dynamic> topCache = jsonDecode(topCacheString);
      setState(() {
        _items.addAll(topCache);
      });
    } else {
      _loadInitialData(); // 初始加载数据
    }
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
    List<dynamic> newData = await getRanks(_page);
    if (_page == 0) {
      await asyncPrefs.setString('top', jsonEncode(newData));
    }
    setState(() {
      _items.addAll(newData);
    });
  }

  // 上拉加载更多
  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    var newData = await getRanks(_page + 1);
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
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // 设置AppBar的最小高度
          child: AppBar(
              // title: Text('自定义AppBar高度'),
              ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _items.length, // 包含加载指示器
            itemBuilder: (context, index) {
              final item = _items[index];
              if (index == _items.length) {
                // 底部加载指示器
                return _isLoadingMore
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }

              return ListTile(
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(item['cover']!), // 图片加载
                  // ),
                  leading: CachedNetworkImage(
                    imageUrl: item['cover'] ?? '',
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        backgroundImage: imageProvider,
                      );
                    },
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(item['title']), // 显示 name 字段
                  subtitle: Text(item['singerName']),
                  onTap: () {
                    onTap(item, ref);
                  });
            },
          ),
        ),
      );
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer(builder: (context, ref, child) {
  //     return ListView.builder(
  //         itemCount: _items.isNotEmpty ? _items.length : 0, // 遍历数组的长度
  //         itemBuilder: (context, index) {
  //           final item = _items[index]; // 获取数组中的元素
  //           return ListTile(
  //               leading: CircleAvatar(
  //                 backgroundImage: NetworkImage(item['cover']!), // 图片加载
  //               ),
  //               title: Text(item['title']), // 显示 name 字段
  //               subtitle: Text(item['singerName']),
  //               onTap: () {
  //                 onTap(item, ref);
  //               });
  //         });
  //   });
  // }
}
