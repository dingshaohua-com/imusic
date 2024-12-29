class Song {
  String name;
  String pic;
  String url;
  Song({this.name = '暂无播放', this.pic = '', this.url = ''});
  Song copyWith({ String? name, String? pic, String? url}) {
    return Song(
      name: name ?? this.name,
      pic: pic ?? this.pic,
      url: url?? this.url
    );
  }
}
