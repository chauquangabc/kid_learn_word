import 'package:go_router/go_router.dart';
import 'package:lingo_bamboo/presentation/ui/auth/login_screen.dart';
import 'package:lingo_bamboo/presentation/ui/auth/register_screen.dart';
import 'package:lingo_bamboo/presentation/ui/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  // initialLocation: '/splash',
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return child;
      },
      branches: [
        StatefulShellBranch(routes: [

        ])
      ],
    ),
  ],
);
