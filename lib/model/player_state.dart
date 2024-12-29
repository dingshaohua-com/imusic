import 'package:imusic/model/song.dart';

class PlayerState {
  String status;
  int duration;
  Song song;
  PlayerState({this.status = 'stop', this.duration = 0, Song? song})
      : song = song ?? Song();
  PlayerState copyWith({String? status, int? duration, Song? song}) {
    return PlayerState(
        status: status ?? this.status,
        duration: duration ?? this.duration,
        song: song ?? this.song);
  }
}
