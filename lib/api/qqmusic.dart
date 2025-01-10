import 'package:dio/dio.dart';
// https://github.com/cfug/dio/issues/191

final dio = Dio();
const orgin = 'https://api.dingshaohua.com/imusic';

/*
* 获取歌单
* */
getSongs(int page) async {
  var url = '$orgin/getSongLists';
  final res = await dio.get(url, queryParameters: {'categoryId': 10000000, 'page': page});
  return res.data['response']['data']['list'];
}


/*
* 获取歌单详情
* */
getSongsDtl(int page, String id) async {
  var url = '$orgin/getSongListDetail';
  final res = await dio.get(url, queryParameters: {'disstid': id, 'page': page});
  return res.data['response']['cdlist'][0]['songlist'];
}