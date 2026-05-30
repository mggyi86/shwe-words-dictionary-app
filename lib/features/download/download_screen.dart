import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/domain/entities/download_status.dart';
import 'package:shwewords/features/initialization/providers/initialization_provider.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadStatus = ref.watch(downloadStatusProvider);
    final initAsync = ref.watch(initializationProvider);
    final colorScheme = Theme.of(context).colorScheme;

    ref.listen(downloadStatusProvider, (prev, next) {
      next.whenData((status) {
        if (status is DownloadStatusReady) {
          context.go(AppRoutes.home);
        }
      });
    });

    final metadata = switch (initAsync.valueOrNull) {
      InitNeedsDownload(:final remoteMetadata) => remoteMetadata,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Download Dictionary')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.cloud_download_outlined,
                size: 64, color: colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              'Dictionary data required',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              metadata != null
                  ? 'Version ${metadata.version} · ${_formatSize(metadata.size)}'
                  : 'Connect to download the offline dictionary database.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            downloadStatus.when(
              data: (status) => _StatusView(status: status),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => Text('Error: $e'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => ref
                  .read(downloadControllerProvider.notifier)
                  .startDownload(metadata: metadata),
              icon: const Icon(Icons.download),
              label: const Text('Download Dictionary'),
            ),
            if (kDebugMode && AppConfig.useBundledDatabaseInDebug) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => ref
                    .read(downloadControllerProvider.notifier)
                    .useBundledDatabase(),
                icon: const Icon(Icons.storage),
                label: const Text('Use Bundled Database (Debug)'),
              ),
            ],
            const SizedBox(height: 12),
            TextButton(
              onPressed: () =>
                  ref.read(downloadControllerProvider.notifier).cancel(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _StatusView extends StatelessWidget {
  const _StatusView({required this.status});

  final DownloadStatus status;

  @override
  Widget build(BuildContext context) {
    return status.when(
      idle: () => const SizedBox.shrink(),
      checking: () => const _StatusRow(
        label: 'Checking...',
        child: LinearProgressIndicator(),
      ),
      downloading: (received, total) {
        final progress = total > 0 ? received / total : null;
        return _StatusRow(
          label:
              'Downloading... ${((progress ?? 0) * 100).toStringAsFixed(0)}%',
          child: LinearProgressIndicator(value: progress),
        );
      },
      decompressing: () => const _StatusRow(
        label: 'Decompressing...',
        child: LinearProgressIndicator(),
      ),
      validating: () => const _StatusRow(
        label: 'Validating database...',
        child: LinearProgressIndicator(),
      ),
      ready: () => const _StatusRow(
        label: 'Ready!',
        child: Icon(Icons.check_circle, color: Colors.green),
      ),
      failed: (message, _) => _StatusRow(
        label: message,
        child: const Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
