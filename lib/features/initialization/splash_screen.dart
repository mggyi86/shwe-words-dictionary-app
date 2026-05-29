import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/widgets/app_logo.dart';
import 'package:shwewords/domain/entities/download_status.dart';
import 'package:shwewords/features/initialization/providers/initialization_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_handleInit);
  }

  Future<void> _handleInit() async {
    final init = await ref.read(initializationProvider.future);

    if (!mounted) return;

    switch (init) {
      case InitReady():
        context.go(AppRoutes.home);
      case InitNeedsDownload():
        context.go(AppRoutes.download);
      case InitChecking():
        break;
      case InitError(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        context.go(AppRoutes.download);
    }
  }

  @override
  Widget build(BuildContext context) {
    final initAsync = ref.watch(initializationProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final logoWidth = screenWidth.clamp(280.0, 480.0);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: AppLogo(
                variant: AppLogoVariant.full,
                width: logoWidth,
              ),
            ),
            const SizedBox(height: 48),
            if (initAsync.isLoading)
              const CircularProgressIndicator()
            else if (initAsync.hasError)
              Column(
                children: [
                  Text('Initialization failed'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        ref.read(initializationProvider.notifier).retry(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
