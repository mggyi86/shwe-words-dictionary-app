import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _connectivityStreamProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(_connectivityStreamProvider);

    final isOffline = connectivity.maybeWhen(
      data: (results) =>
          results.isEmpty ||
          results.every((r) => r == ConnectivityResult.none),
      orElse: () => false,
    );

    if (!isOffline) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Tooltip(
        message: 'Offline mode',
        child: Icon(
          Icons.cloud_off_outlined,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
