// PlayerStateNotifier 用于更新 PlayerState
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/model/player_state.dart';
import 'package:imusic/api/index.dart';
import 'package:imusic/utils/player.dart';

var player = Player.getInstance();

class PlayerStateNotifier extends StateNotifier<PlayerState> {
  PlayerStateNotifier() : super(PlayerState());

  // 播放歌曲
  void play(String musicId) async {
    // 模拟获取歌曲信息
    final song = await await getMusic(musicId);

    // 播放歌曲（这里调用你自己的播放器 API）
    var playStatus = await player.play(song['musicUrl']);
    if (playStatus) {
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
    }
  }

  // 恢复播放
  resume() {
    state = state.copyWith(status: 'playing');
    player.resume();
  }

  // 恢复或重新播放歌曲
  playOrResume(String musicId) {
    var isResume = musicId == state.songId;
    isResume ? resume() : play(musicId);
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
    // player.stop();
  }

  // 暂停播放
  void pause() {
    state = state.copyWith(status: 'stop');
    player.pause();
  }

  // 最大化
  void openMax(){
    state = state.copyWith(isPlayerFullVisible: true);
  }
}

// 使用 StateNotifierProvider 来提供 PlayerStateNotifier
final playerStateProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier();
});
