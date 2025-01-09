import 'package:go_router/go_router.dart';
import '../components/scaffold_bar.dart';
import 'package:imusic/pages/home.dart';
import 'package:imusic/pages/about.dart';
import 'package:imusic/pages/songs.dart';

// 定义路由
final GoRouter router = GoRouter(
  initialLocation: '/songs',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/songs', builder: (context, state) => const SongsPage()),
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
                path: '/about',
                builder: (context, state) => const AboutPage()),
          ],
        ),
      ],
    )
  ],
);