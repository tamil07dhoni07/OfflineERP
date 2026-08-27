import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import 'buttons.dart';

class QuickField {
  QuickField(this.label, {String initial = '', this.keyboardType}) : controller = TextEditingController(text: initial);
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
}

/// A small modal form for the master-data "New X" actions — real inserts,
/// not just a button that does nothing.
Future<void> showQuickAddDialog({
  required BuildContext context,
  required String title,
  required List<QuickField> fields,
  required Future<void> Function() onSubmit,
}) {
  return showRecordFormDialog(context: context, title: title, fields: fields, onSubmit: onSubmit);
}

/// Same form, but also usable to edit an existing record: pass
/// `submitLabel: 'Save'` and, to allow deleting it from the same dialog,
/// `onDelete`. A confirmation step guards the delete so a stray tap can't
/// remove a record.
Future<void> showRecordFormDialog({
  required BuildContext context,
  required String title,
  required List<QuickField> fields,
  required Future<void> Function() onSubmit,
  String submitLabel = 'Create',
  Future<void> Function()? onDelete,
  String deleteConfirmMessage = 'This cannot be undone.',
}) {
  return showDialog(
    context: context,
    builder: (context) {
      var submitting = false;
      String? error;
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> submit() async {
            setState(() {
              submitting = true;
              error = null;
            });
            try {
              await onSubmit();
              if (context.mounted) Navigator.of(context).pop();
            } catch (e) {
              setState(() {
                error = '$e';
                submitting = false;
              });
            }
          }

          Future<void> confirmDelete() async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.card,
                title: const Text('Delete this record?'),
                content: Text(deleteConfirmMessage),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
                  ),
                ],
              ),
            );
            if (confirmed != true) return;
            setState(() {
              submitting = true;
              error = null;
            });
            try {
              await onDelete!();
              if (context.mounted) Navigator.of(context).pop();
            } catch (e) {
              setState(() {
                error = '$e';
                submitting = false;
              });
            }
          }

          return Dialog(
            backgroundColor: AppColors.card,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.sans(size: 16, weight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    for (final f in fields)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f.label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                            const SizedBox(height: 5),
                            Container(
                              height: 38,
                              padding: const EdgeInsets.symmetric(horizontal: 11),
                              decoration: BoxDecoration(
                                color: AppColors.fieldFill,
                                border: Border.all(color: AppColors.fieldBorder),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: TextField(
                                controller: f.controller,
                                keyboardType: f.keyboardType,
                                style: AppText.sans(size: 13),
                                decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (error != null) ...[
                      Text(error!, style: AppText.sans(size: 12, color: AppColors.danger)),
                      const SizedBox(height: 8),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (onDelete != null)
                          TextButton(
                            onPressed: submitting ? null : confirmDelete,
                            child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
                          ),
                        const Spacer(),
                        SecondaryButton(label: 'Cancel', onTap: submitting ? null : () => Navigator.of(context).pop()),
                        const SizedBox(width: 8),
                        PrimaryButton(label: submitting ? 'Saving…' : submitLabel, onTap: submitting ? null : submit),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
