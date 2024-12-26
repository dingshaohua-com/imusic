import 'package:dio/dio.dart';

final dio = Dio();
const yaohudOrgin = 'https://api.yaohud.cn/api/qqmusic/v2';

/// 获取热歌榜
getTopId() async {
  final res = await dio.get(yaohudOrgin,
      queryParameters: {'key': 'WzwNdjdg5kUuqM2A0z7', 'type': 'topgroup'});
  var topList = res.data['data'][0]; // 请求完成后更新数据(巅峰榜)
  var hotMusic = topList['toplist'][1]; // 热歌榜
  var hotTopId = hotMusic['topId']; // 热歌榜id
  var hotPeriod = hotMusic['period']; // 最热id
  return {'hotTopId': hotTopId, 'hotPeriod': hotPeriod}; //返回了一个map
}

getHotMusic()async{
  var hotInfo = await getTopId();
  // Dart 中定义 Map 的简写方式：由于您没有明确指定 Map 的类型参数，Dart 会推断 params 的类型为 Map<String, dynamic>
  var params = {
    'key': 'WzwNdjdg5kUuqM2A0z7',
    'type': 'toplist',
    'topid': hotInfo['hotTopId'],
    'period': hotInfo['hotPeriod']
  };
  final res = await dio.get(yaohudOrgin, queryParameters: params);
  return res.data['data']['list'];
}
