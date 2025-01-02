// PlayerStateNotifier 用于更新 PlayerState
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/model/player_state.dart';
import 'package:imusic/api/index.dart';
import 'package:imusic/utils/player.dart';

var player = Player.getInstance();

class PlayerStateNotifier extends StateNotifier<PlayerState> {
  PlayerStateNotifier() : super(PlayerState()) {
    print('PlayerStateNotifier initialized');

    // 监听播放位置变化
    var player = Player.audioPlayer;
    player.onDurationChanged.listen((Duration position) {
      print('onDurationChanged: $position');
    });

    player.onPositionChanged.listen((p) {
      // print('onPositionChanged: $p');
      state = state.copyWith(position: p);
    });

    player.onPlayerComplete.listen((event) {
      // print('onPlayerComplete');
    });

    player.onPlayerStateChanged.listen((state) {
      // print('onPlayerStateChanged');
    });
  }

  // 播放歌曲
  void play(String musicId) async {
    final song = await getMusic(musicId);
    var duration = await Player.audioPlayer.getDuration();

    var playStatus = await player.play(song['musicUrl']);
    if (playStatus) {
      state = state.copyWith(
        status: 'playing',
        songId: song['mid'],
        songName: song['title'],
        songUrl: song['musicUrl'],
        coverUrl: song['pic'],
        author: song['author'],
        duration: duration,
        position: Duration.zero,
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
      author: '',
      duration: Duration.zero,
      position: Duration.zero,
    );
  }

  // 暂停播放
  void pause() {
    state = state.copyWith(status: 'stop');
    player.pause();
  }

  // 最大化播放器
  void openMax() {
    state = state.copyWith(isPlayerFullVisible: true);
  }
}

// 使用 StateNotifierProvider 来提供 PlayerStateNotifier
final playerStateProvider =
    StateNotifierProvider<PlayerStateNotifier, PlayerState>((ref) {
  return PlayerStateNotifier();
});
