import 'dart:convert';

getSongsParams(){
  var params = {
    "g_tk": 1278911659,
    "jsonpCallback": "recom3477297233556247",
    "loginUin": 0,
    "hostUin": 0,
    "format": "json",
    "inCharset": "utf8",
    "outCharset": "utf-8¬ice=0",
    "platform": "yqq",
    "needNewCode": 0,
    "data": {
      "comm": {"ct": 24},
      "category": {
        "method": "get_hot_category",
        "param": {"qq": ""},
        "module": "music.web_category_svr"
      },
      "recomPlaylist": {
        "method": "get_hot_recommend",
        "param": {"async": 1, "cmd": 2},
        "module": "playlist.HotRecommendServer"
      },
      "playlist": {
        "method": "get_playlist_by_category",
        "param": {"id": 8, "curPage": 1, "size": 10, "order": 5, "titleid": 8},
        "module": "playlist.PlayListPlazaServer"
      },
      "new_song": {
        "module": "QQMusic.MusichallServer",
        "method": "GetNewSong",
        "param": {"type": 0}
      },
      "new_album": {
        "module": "QQMusic.MusichallServer",
        "method": "GetNewAlbum",
        "param": {
          "type": 0,
          "category": "-1",
          "genre": 0,
          "year": 1,
          "company": -1,
          "sort": 1,
          "start": 0,
          "end": 39
        }
      },
      "toplist": {
        "module": "music.web_toplist_svr",
        "method": "get_toplist_index",
        "param": {}
      },
      "focus": {
        "module": "QQMusic.MusichallServer",
        "method": "GetFocus",
        "param": {}
      }
    }
  };
  params['data'] = jsonEncode(params['data']);
  return params;
}