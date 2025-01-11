import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../components/scaffold_bar.dart';
import 'package:imusic/pages/home.dart';
import 'package:imusic/pages/about.dart';
import 'package:imusic/pages/songs.dart';
import 'package:imusic/pages/songs_dtl.dart';

// 定义路由
final GoRouter router = GoRouter(
  initialLocation: '/songs',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // 判断是否需要显示底部导航栏
        List<String> paths = ['/songs', '/home', '/about'];
        bool showNavBar =
            paths.any((path) => state.uri.toString() == path.toString());
        return ScaffoldWithNavBar(
            navigationShell: navigationShell, showNavBar: showNavBar);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/songs',
              builder: (context, state) => const SongsPage(),
              routes: [
                GoRoute(
                  // parentNavigatorKey: _sectionANavigatorKey,
                  path: 'songs_dtl',
                  builder: (context, state) {
                    var id = GoRouterState.of(context).uri.queryParameters['id'].toString();
                    return SongsDtlPage(id: id);
                  }

                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/home', builder: (context, state) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/about', builder: (context, state) => const AboutPage()),
          ],
        ),
      ],
    )
  ],
);
