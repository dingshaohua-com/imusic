import 'dart:math';

import 'package:dio/dio.dart';
// https://github.com/cfug/dio/issues/191

final dio = Dio();
const origin = 'https://qmusic.dingshaohua.com';
// const origin = 'http://192.168.2.136:3001';

/*
* 获取歌单
* */
getSongs(int page) async {
  var url = '$origin/getSongLists';
  final res = await dio
      .get(url, queryParameters: {'categoryId': 10000000, 'page': page});
  return res.data['data'];
}

/*
* 获取歌单详情
* */
getSongsDtl(int page, String id) async {
  var url = '$origin/getSongListDetail';
  print('开始请求');
  print(url);
  final res =
      await dio.get(url, queryParameters: {'disstid': id, 'page': page});
  print('结束请求');
  return res.data['data'];
}

/*
* 获取排行榜
* */
// getTopLists(int page) async {
//   var url = '$origin/getTopLists';
//   final res = await dio.get(url, queryParameters: {'page': page});
//   print(1111111);
//   print(res);
//   return res.data['data'];
// }

/*
* 获取排行榜
* */
getRanks(int page) async {
  var url = '$origin/getRanks';
  final res = await dio.get(url, queryParameters: {'page': page});
  return res.data['data'];
}

/*
* 获取歌曲详情
* */
getSongInfo(String id) async {
  var url = '$origin/getSongInfo';
  final res = await dio.get(url, queryParameters: {'songmid': id});
  final musicUrlRes = await dio.get('$origin/getMusicPlay', queryParameters: {'songmid': id});
  var songBaseInfo = res.data['data']['track_info'];
  var albumMid = songBaseInfo["album"]["mid"];
  var cover = "https://y.qq.com/music/photo_new/T002R300x300M000${albumMid}.jpg?max_age=2592000";
  var result =  {
    "mid": id,
    "title": songBaseInfo['title'],
    "musicUrl": musicUrlRes.data['data'],
    "author": songBaseInfo["singer"][0]["name"],
    "pic":cover
  };
  print(11112233);
  print(result);
  return result;
}

getMusic(String mid) async {
  var url = '$origin/getMusicPlay';
  final res = await dio.get(url, queryParameters: {'songmid': mid});
  return res.data['data'];
}
