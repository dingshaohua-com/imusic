class AppState {

  final bool isBottomBarVisible;

  AppState({
    this.isBottomBarVisible = true
  });


  AppState copyWith({
    bool? isBottomBarVisible
  }) {
    return AppState(
        isBottomBarVisible: isBottomBarVisible ?? this.isBottomBarVisible,
    );
  }
}
