// PlayerStateNotifier 用于更新 PlayerState
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/model/player_state.dart';
import 'package:imusic/api/index.dart';
import 'package:imusic/model/player.dart';

var player = Player.getInstance();

class PlayerStateNotifier extends StateNotifier<PlayerState> {
  PlayerStateNotifier() : super(PlayerState());

  // 播放歌曲
  void play(String musicId) async {
    // 模拟获取歌曲信息
    final song = await await getMusic(musicId);

    // 更新状态
    state = state.copyWith(
      status: 'playing',
      songId: song['mid'],
      songName: song['title'],
      songUrl: song['musicUrl'],
      coverUrl: song['pic'],
      duration: 0, // 假设歌曲信息中有总时长
      // duration: song['duration'],  // 假设歌曲信息中有总时长
      currentPosition: 0, // 播放开始时，进度从 0 开始
    );

    // 播放歌曲（这里调用你自己的播放器 API）
    _playSong(song['musicUrl']);
  }

  // 恢复或重新播放歌曲
  playOrResume(String musicId) {
    if (musicId == state.songId) {
      print('继续播放');
      state = state.copyWith(status: 'playing');
      player.resume();
    } else {
      print('新的播放');
      play(musicId);
    }
  }

  // 停止播放
  void stop() {
    state = state.copyWith(
        status: 'stop',
        songId: '',
        songName: 'No Song',
        songUrl: '',
        coverUrl: '',
        duration: 0,
        currentPosition: 0);
    _stopSong();
  }

  // 暂停播放
  void pause() {
    state = state.copyWith(status: 'stop');
    player.pause();
  }

  // 播放歌曲
  void _playSong(String url) {
    player.play(url);
    print('Playing song from URL: $url');
    // 这里调用你自己的播放器库来播放歌曲
  }

  // 停止播放
  void _stopSong() {
    print('Song stopped');
    // 这里调用你自己的播放器库来停止播放
  }
}

// 使用 StateNotifierProvider 来提供 PlayerStateNotifier
final playerStateProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier();
});
