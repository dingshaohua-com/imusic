import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/model/player_state.dart';

final playerProvider = StateProvider<PlayerState>(
  (ref) => PlayerState(),
);
