import 'dart:convert';
import 'package:dio/dio.dart';
import "package:imusic/api/helper.dart";
// https://github.com/cfug/dio/issues/191

final dio = Dio();

/*
* 获取歌单
* */
getSongs() async {
  var options = Options(
      responseType: ResponseType.plain); // 设置为 plain，避免自动解析
  var params = getSongsParams();
  const url = 'https://u.y.qq.com/cgi-bin/musicu.fcg';
  final res = await dio.get(url, queryParameters: params,options: options);
  var result = jsonDecode(res.data); // 后端返回虽然是json，但是响应头 content-type:text/plain; charset=utf-8;
  print(1111);
  print(result);
  return result['playlist']['data']['v_playlist'];
}
