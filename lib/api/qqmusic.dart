import 'dart:math';

import 'package:dio/dio.dart';
// https://github.com/cfug/dio/issues/191

final dio = Dio();
// const origin = 'https://qmusic.dingshaohua.com';
const origin = 'http://192.168.2.136:3001';

/*
* 获取歌单
* */
getSongs(int page) async {
  var url = '$origin/getSongLists';
  final res = await dio.get(url, queryParameters: {'categoryId': 10000000, 'page': page});
  return res.data['data'];
}


/*
* 获取歌单详情
* */
getSongsDtl(int page, String id) async {

  var url = '$origin/getSongListDetail';
  print('开始请求');
  print(url);
  final res = await dio.get(url, queryParameters: {'disstid': id, 'page': page});
  print('结束请求');
  return res.data['data'];
}