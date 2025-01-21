import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imusic/api/qqmusic.dart';
import 'package:marquee/marquee.dart';
import '../store/player_state_notifier.dart';

class SongsDtlPage extends StatefulWidget {
  final String id;
  const SongsDtlPage({super.key, required this.id});
  @override
  SongsDtlPageState createState() => SongsDtlPageState();
}

class SongsDtlPageState extends State<SongsDtlPage> {
  final List<dynamic> _items = []; // 数据列表
  String dissname = '';
  String desc = '';
  String logo = '';

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
    var newData = await getSongsDtl(_page, widget.id);
    print(111);
    print(newData);

    // 首次赋值，后续就不在更新了
    if (dissname == '') {
      setState(() {
        dissname = newData['dissname'];
        desc = newData['desc'];
        logo = newData['logo'];
      });
    }
    setState(() {
      _items.addAll(newData['songlist']);
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
        // 设置背景透明
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // 返回按钮点击事件
          },
        ),
      ),
      extendBodyBehindAppBar: true, // 让body延伸到AppBar后面 如果不延伸，也不会是透明
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.blueGrey,
                width: double.infinity,
                height: 300,
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: logo.isEmpty
                          ? SvgPicture.asset('assets/img/music.svg',
                              width: double.infinity, fit: BoxFit.cover)
                          : CachedNetworkImage(
                              imageUrl: logo,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),

                      // Image.network(
                      //         logo,
                      //         width: double.infinity,
                      //         fit: BoxFit.cover,
                      //       ),
                    ),
                    Positioned(
                      top: 30,
                      bottom: 0,
                      left: 0,
                      right: 0, // 确保从左到右的布局可以居中
                      child: Align(
                          alignment: Alignment.center, // 设置内容水平居中
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 180, // 设置最大高度
                            ),
                            padding: const EdgeInsets.only(
                                top: 16, right: 20, bottom: 20, left: 20),
                            color: const Color.fromARGB(120, 0, 0, 0),
                            child: SingleChildScrollView(
                                child: Column(
                              mainAxisSize:
                                  MainAxisSize.min, // 设置 Column 高度为内容最小高度
                              children: [
                                Text(
                                  dissname,
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 20),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.only(top: 10), // 设置外边距
                                    width: double.infinity,
                                    // height: 30,
                                    child: HtmlWidget(
                                      desc,
                                      textStyle: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )),
                              ],
                            )),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // 显示加载状态的占位符
                  final item = _items[index]; // 获取数组中的元素
                  return ListTile(
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(item['pic']!), // 图片加载
                    // ),
                    title: Text(item['title']), // 显示 name 字段
                    subtitle: Text(item['singer']
                        .map((singer) => singer['title'])
                        .join('、')),
                    onTap: () {
                      print('点击了');
                      // onTap(item, ref);
                    },
                  );
                },
                childCount: _items.isNotEmpty ? _items.length : 0, // 遍历数组的长度
              ),
            ),
          ],
        ),
      ),
    );
  }
}
