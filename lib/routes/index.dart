import 'package:go_router/go_router.dart';
import '../components/scaffold_bar.dart';
import 'package:imusic/pages/home.dart';
import 'package:imusic/pages/about.dart';
import 'package:imusic/pages/songs.dart';

final GoRouter router = GoRouter(
  initialLocation: '/song',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        // 显示在底部导航栏下方的子路由
        GoRoute(
          path: '/song',
          builder: (context, state) {
            return const SongsPage();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) {
            return const AboutPage();
          },
        ),
      ],
    ),
  ],
);
