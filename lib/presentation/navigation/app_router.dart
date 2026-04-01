import 'package:go_router/go_router.dart';
import 'package:lingo_bamboo/presentation/ui/auth/login_screen.dart';
import 'package:lingo_bamboo/presentation/ui/auth/register_screen.dart';
import 'package:lingo_bamboo/presentation/ui/game/game_screen.dart';
import 'package:lingo_bamboo/presentation/ui/home/home_screen.dart';
import 'package:lingo_bamboo/presentation/ui/profile/profile_screen.dart';
import 'package:lingo_bamboo/presentation/ui/setting/setting_screen.dart';
import 'package:lingo_bamboo/presentation/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lingo_bamboo/presentation/ui/story/story_screen.dart';

import '../ui/home/topic_screen.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: '/splash',
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/setting', builder: (context, state) => SettingScreen()),
    GoRoute(
      path: '/topic/:topicId',
      builder: (context, state) {
        final topicId = state.pathParameters['topicId'];
        return TopicScreen(topicId: topicId!);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/game',
              builder: (context, state) => const GameScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/story',
              builder: (context, state) => const StoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    // Chuyển đổi giữa các branch
    navigationShell.goBranch(
      index,
      // Hỗ trợ quay lại trang đầu tiên của branch nếu nhấn lại vào tab đang chọn
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, // Hiển thị nội dung của branch hiện tại
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Sử dụng khi có từ 4 tab trở lên
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Story',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Game'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
