import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imusic/emiiter.dart';

// 根组件（root widget）
class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  late List<dynamic> _topGroup; // 用于保存请求结果

  @override
  void initState() {
    super.initState();
    _topGroup = []; // 初始状态
    _loadData(); // 发起请求
  }

  // 异步 HTTP 请求方法
  void _loadData() async {
    try {
      final dio = Dio();
      const orgin = 'https://api.yaohud.cn/api/qqmusic/v2';
      final res = await dio.get(orgin,
          queryParameters: {'key': 'WzwNdjdg5kUuqM2A0z7', 'type': 'topgroup'});
      var toplist = res.data['data'][0]; // 请求完成后更新数据(巅峰榜)
      var hotMisic = toplist['toplist'][1]; // 热歌榜
      var hotTopid = hotMisic['topId']; // 热歌榜id
      var hotPeriod = hotMisic['period'];

      final res1 = await dio.get(orgin, queryParameters: {
        'key': 'WzwNdjdg5kUuqM2A0z7',
        'type': 'toplist',
        'topid': hotTopid,
        'period': hotPeriod
      });

      print(res1.data['data']['list']);
      setState(() {
        _topGroup = res1.data['data']['list'];
      });
    } catch (e) {
      setState(() {
        // _data = "请求失败: $e"; // 错误处理
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _topGroup.length, // 遍历数组的长度
          itemBuilder: (context, index) {
            final item = _topGroup[index]; // 获取数组中的元素
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item['pic']!), // 图片加载
              ),
              title: Text(item['title']), // 显示 name 字段
              subtitle: Text(item['author']),
              onTap: () {
                eventBus.fire(MusicEvent('哈哈'));
              },
            );
          },
        ),
      ),
    );
  }
}
