import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

final auditLogsProvider = StreamProvider((ref) => ref.watch(auditRepositoryProvider).watchRecent());

class AuditScreen extends ConsumerWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(auditLogsProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load audit log: $e'),
      data: (logs) {
        final rows = logs
            .map(
              (l) => RowSpec([
                Cell.text(DateFormat('d MMM HH:mm').format(l.timestamp), mono: true, color: AppColors.mutedInk),
                Cell.text(l.username),
                Cell.text(l.module, color: AppColors.mutedInk),
                Cell.text(l.action, mono: true, weight: FontWeight.w500),
                Cell.text(l.recordRef, mono: true),
                Cell.text('${l.oldValue} → ${l.newValue}', color: AppColors.mutedInk),
                Cell.text(l.device, mono: true, color: AppColors.mutedInk),
              ]),
            )
            .toList();

        final spec = TableSpec(
          title: 'Audit Log',
          subtitle: 'Every sensitive operation, retained locally and readable offline',
          devNote: 'features/audit · audit_logs · old_value / new_value',
          filters: const [FilterSpec('Module', 'All'), FilterSpec('User', 'Anyone'), FilterSpec('Period', 'All time')],
          columns: const [
            ColumnSpec('TIMESTAMP'),
            ColumnSpec('USER'),
            ColumnSpec('MODULE'),
            ColumnSpec('ACTION'),
            ColumnSpec('RECORD'),
            ColumnSpec('OLD → NEW'),
            ColumnSpec('DEVICE'),
          ],
          rows: rows,
          count: '${rows.length} entries · append-only, soft-delete never removes rows',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}
