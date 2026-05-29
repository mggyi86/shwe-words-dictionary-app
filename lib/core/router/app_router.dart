import 'package:go_router/go_router.dart';
import 'package:shwewords/features/download/download_screen.dart';
import 'package:shwewords/features/history/history_screen.dart';
import 'package:shwewords/features/initialization/splash_screen.dart';
import 'package:shwewords/features/search/search_screen.dart';
import 'package:shwewords/features/settings/settings_screen.dart';
import 'package:shwewords/features/word_detail/word_detail_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const download = '/download';
  static const home = '/home';
  static const wordDetail = '/word/:id';
  static const history = '/history';
  static const settings = '/settings';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.download,
      builder: (context, state) => const DownloadScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.wordDetail,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return WordDetailScreen(entryId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.history,
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
