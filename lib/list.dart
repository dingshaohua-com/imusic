import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// 根组件（root widget）
class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  late String _data; // 用于保存请求结果

  @override
  void initState() {
    super.initState();
    _data = "加载中..."; // 初始状态
    _getHttp(); // 发起请求
  }

  // 异步 HTTP 请求方法
  void _getHttp() async {
    try {
      final dio = Dio();
      const orgin = 'https://jsonplaceholder.typicode.com';
      final response = await dio.get('$orgin/posts/1'); // 示例 URL
      setState(() {
        _data = response.data.toString(); // 请求完成后更新数据
      });
    } catch (e) {
      setState(() {
        _data = "请求失败: $e"; // 错误处理
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP 请求示例'),
      ),
      body: Center(
        child: Text(_data), // 根据 _data 来更新 UI
      ),
    );
  }
}
