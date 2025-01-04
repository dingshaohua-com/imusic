import 'dart:convert';
import 'package:dio/dio.dart';
import "package:imusic/api/helper.dart";

final dio = Dio();

/*
* 获取歌单
* */
getSongs() async {
  dio.options.headers = {
    'Content-Type': 'application/json;charset=UTF-8'
  };
  var params = getSongsParams();
  const url = "https://u.y.qq.com/cgi-bin/musicu.fcg";
  print(params);
  final res = await dio.get(url, queryParameters: params);
  print(res);
}
