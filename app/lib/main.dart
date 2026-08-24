import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/app_database.dart';
import 'core/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: NexusErpBootstrap()));
}

/// Opens (and, on first run, seeds) the local database before anything else
/// mounts — every screen assumes [databaseProvider] is already live.
class NexusErpBootstrap extends ConsumerStatefulWidget {
  const NexusErpBootstrap({super.key});

  @override
  ConsumerState<NexusErpBootstrap> createState() => _NexusErpBootstrapState();
}

class _NexusErpBootstrapState extends ConsumerState<NexusErpBootstrap> {
  late final Future<AppDatabase> _dbFuture = openAndSeedDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDatabase>(
      future: _dbFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(theme: AppTheme.light(), home: const _SplashScreen());
        }
        if (snapshot.hasError) {
          return MaterialApp(theme: AppTheme.light(), home: _ErrorScreen(error: snapshot.error!));
        }
        return ProviderScope(
          overrides: [databaseProvider.overrideWithValue(snapshot.data!)],
          child: const NexusErpApp(),
        );
      },
    );
  }
}

class NexusErpApp extends ConsumerWidget {
  const NexusErpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Nexus ERP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(9)),
              alignment: Alignment.center,
              child: Text('N', style: AppText.sans(size: 16, weight: FontWeight.w700, color: AppColors.white)),
            ),
            const SizedBox(height: 16),
            const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent)),
            const SizedBox(height: 14),
            Text('Opening local database…', style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Could not open the local database:\n$error', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
