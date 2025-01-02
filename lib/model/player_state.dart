class PlayerState {
  final String status; // 'stop' 或 'playing'
  final String songId; // 当前播放的歌曲Id
  final String songName; // 当前播放的歌曲名称
  final String songUrl; // 歌曲播放地址
  final String coverUrl; // 歌曲封面图
  final String author; // 歌曲作者
  final Duration duration; // 歌曲总时长，单位：秒
  final int currentPosition; // 当前播放进度，单位：秒
  final bool isPlayerFullVisible;

  PlayerState(
      {this.status = 'stop',
      this.songId = '',
      this.songName = '暂无播放', // 默认值为 'No Song'
      this.songUrl = '',
      this.coverUrl = '',
      this.author = '',
      this.duration =  Duration.zero, // 默认值为 0
      this.currentPosition = 0, // 默认值为 0
      this.isPlayerFullVisible = false});

  // 恢复初始值
  PlayerState reset() {
    return PlayerState(); // 返回一个新的 PlayerState 实例，使用默认值
  }

  PlayerState copyWith({
    String? status,
    String? songId,
    String? songName,
    String? songUrl,
    String? coverUrl,
    String? author,
    Duration? duration,
    int? currentPosition,
    bool? isPlayerFullVisible,
  }) {
    return PlayerState(
        status: status ?? this.status,
        songId: songId ?? this.songId,
        songName: songName ?? this.songName,
        songUrl: songUrl ?? this.songUrl,
        coverUrl: coverUrl ?? this.coverUrl,
        author: author ?? this.author,
        duration: duration ?? this.duration,
        currentPosition: currentPosition ?? this.currentPosition,
        isPlayerFullVisible: isPlayerFullVisible ?? this.isPlayerFullVisible);
  }
}
