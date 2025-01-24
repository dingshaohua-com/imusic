// PlayerStateNotifier 用于更新 PlayerState
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imusic/model/player_state.dart';
import 'package:imusic/utils/player.dart';

import '../model/app_state.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void hideBottomBar() {
    // 更新状态
    state = state.copyWith(isBottomBarVisible: false);
  }

  void showBottomBar() {
    // 更新状态
    state = state.copyWith(isBottomBarVisible: true);
  }
}

// 使用 StateNotifierProvider 来提供 PlayerStateNotifier
final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
