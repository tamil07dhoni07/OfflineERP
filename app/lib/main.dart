import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/backup/drive_backup_service.dart';
import 'core/providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_controller.dart';

/// Opens (and, on first run, seeds) the local database *before* the real
/// provider tree exists, then mounts a single root [ProviderScope] with
/// [databaseProvider] overridden.
///
/// This runs before any provider is read, on purpose: a nested inner
/// ProviderScope created *after* an outer one is already live doesn't work
/// for this — Riverpod resolves a provider against whichever container it
/// was first instantiated in, and any provider without a *local* override
/// (e.g. authControllerProvider, which only depends on databaseProvider
/// indirectly) gets created in the outer/root container, not the inner one.
/// So an override added only to the inner scope is invisible to it. Doing
/// the async work first and creating exactly one root scope avoids that.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const _BootSplash());

  try {
    // A Google Drive restore stages its bytes next to the real database
    // file rather than swapping it live (see DriveBackupService) — apply
    // it now, before anything opens a connection to that file.
    if (!kIsWeb) await DriveBackupService.applyStagedRestoreIfAny();
    final db = await openAndSeedDatabase();
    final keptUser = await restoreKeptSignInUser(db);
    runApp(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          authControllerProvider.overrideWith((ref) => AuthController(ref, initialUser: keptUser)),
        ],
        child: const NexusErpApp(),
      ),
    );
  } catch (error) {
    runApp(_BootError(error: error));
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

class _BootSplash extends StatelessWidget {
  const _BootSplash();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Scaffold(
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
      ),
    );
  }
}

class _BootError extends StatelessWidget {
  const _BootError({required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Scaffold(
        backgroundColor: AppColors.paper,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not open the local database:\n$error', textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
