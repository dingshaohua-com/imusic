import 'dart:math';

import 'package:dio/dio.dart';
// https://github.com/cfug/dio/issues/191

final dio = Dio();
const origin = 'https://qmusic.dingshaohua.com';

/*
* 获取歌单
* */
getSongs(int page) async {
  var url = '$origin/getSongLists';
  print(url);
  final res = await dio.get(url, queryParameters: {'categoryId': 10000000, 'page': page});
  return res.data['data'];
}


/*
* 获取歌单详情
* */
getSongsDtl(int page, String id) async {
  var url = '$origin/getSongListDetail';
  final res = await dio.get(url, queryParameters: {'disstid': id, 'page': page});
  return res.data['data'];
}