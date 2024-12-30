class PlayerState {

  final String status;        // 'stop' 或 'playing'
  final String  songId;       // 当前播放的歌曲Id
  final String songName;      // 当前播放的歌曲名称
  final String songUrl;       // 歌曲播放地址
  final String coverUrl;      // 歌曲封面图
  final int duration;         // 歌曲总时长，单位：秒
  final int currentPosition;  // 当前播放进度，单位：秒

  PlayerState({
    this.status = 'stop',
    this.songId = '',
    this.songName = '暂无播放', // 默认值为 'No Song'
    this.songUrl = '',
    this.coverUrl = '',
    this.duration = 0,         // 默认值为 0
    this.currentPosition = 0,  // 默认值为 0
  });

  // 恢复初始值
  PlayerState reset() {
    return PlayerState();  // 返回一个新的 PlayerState 实例，使用默认值
  }

  PlayerState copyWith({
    String? status,
    String? songId,
    String? songName,
    String? songUrl,
    String? coverUrl,
    int? duration,
    int? currentPosition,
  }) {
    return PlayerState(
      status: status ?? this.status,
      songId: songId ?? this.songId,
      songName: songName ?? this.songName,
      songUrl: songUrl ?? this.songUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      duration: duration ?? this.duration,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
