import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/database/seed.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _username = TextEditingController(text: 'r.deshmukh');
  final _password = TextEditingController(text: seedDevPassword);
  bool _submitting = false;
  bool _keepSignedIn = true;
  String? _error;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _toggleKeepSignedIn() => setState(() => _keepSignedIn = !_keepSignedIn);

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    final ok = await ref.read(authControllerProvider.notifier).signIn(_username.text.trim(), _password.text);
    if (!mounted) return;
    setState(() {
      _submitting = false;
      _error = ok ? null : ref.read(authControllerProvider.notifier).lastError;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 860;
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 21, child: _BrandPanel()),
                  Expanded(flex: 20, child: _SignInPanel(state: this)),
                ],
              )
            : SingleChildScrollView(child: _SignInPanel(state: this)),
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebar,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text('N', style: AppText.sans(size: 14, weight: FontWeight.w700, color: AppColors.white)),
              ),
              const SizedBox(width: 11),
              Text(
                'Nexus ERP',
                style: AppText.sans(size: 15, weight: FontWeight.w600, color: AppColors.paper, letterSpacing: -0.15),
              ),
            ],
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your books keep working when the network doesn't.",
                  style: AppText.sans(size: 38, weight: FontWeight.w600, color: AppColors.paper, height: 1.12, letterSpacing: -0.9),
                ),
                const SizedBox(height: 22),
                Text(
                  'All operational data lives in the local database on this device. Firebase is contacted only for licensing and configuration — never for your transactions.',
                  style: AppText.sans(size: 14, color: AppColors.mutedLightest, height: 1.65),
                ),
                const SizedBox(height: 28),
                const _StatusLine(color: AppColors.success, text: 'Local SQLite / Drift · live on device'),
                const SizedBox(height: 9),
                const _StatusLine(color: AppColors.success, text: 'Last encrypted Drive backup · today 04:00'),
                const SizedBox(height: 9),
                const _StatusLine(color: AppColors.warn, text: 'License revalidation due in 21 days'),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'v1.0.0 · build 1 · device WIN-MUM-04',
            style: AppText.mono(size: 11, color: const Color(0xFF7A736A)),
          ),
        ],
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 5, height: 5, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text, style: AppText.sans(size: 12.5, color: const Color(0xFFCFC9BD))),
      ],
    );
  }
}

class _SignInPanel extends StatelessWidget {
  const _SignInPanel({required this.state});
  final _LoginScreenState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 372),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sign in', style: AppText.sans(size: 24, weight: FontWeight.w600, letterSpacing: -0.4)),
              const SizedBox(height: 6),
              Text('Nexus Traders Pvt Ltd · Mumbai HQ', style: AppText.sans(size: 13, color: AppColors.mutedInk)),
              const SizedBox(height: 22),
              const _FieldLabel('USERNAME'),
              const SizedBox(height: 6),
              _TextField(controller: state._username),
              const SizedBox(height: 14),
              const _FieldLabel('PASSWORD'),
              const SizedBox(height: 6),
              _TextField(controller: state._password, obscure: true, onSubmit: state._submit),
              const SizedBox(height: 14),
              Row(
                children: [
                  GestureDetector(
                    onTap: state._toggleKeepSignedIn,
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: state._keepSignedIn ? AppColors.accent : AppColors.card,
                            border: Border.all(color: AppColors.dashedBorder),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Keep me signed in on this device', style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text('Use PIN', style: AppText.sans(size: 12.5, weight: FontWeight.w500, color: AppColors.accent)),
                ],
              ),
              const SizedBox(height: 4),
              if (state._error != null) ...[
                const SizedBox(height: 10),
                Text(state._error!, style: AppText.sans(size: 12, color: AppColors.danger)),
              ],
              const SizedBox(height: 10),
              GestureDetector(
                onTap: state._submitting ? null : state._submit,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: state._submitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
                          )
                        : Text(
                            'Sign in offline',
                            style: AppText.sans(size: 14, weight: FontWeight.w600, color: AppColors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(top: 16),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'features/auth · users · PBKDF2-SHA256 · verified locally',
                      style: AppText.mono(size: 11, color: AppColors.mutedFaint),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Credentials are checked against the local user table. No network round-trip is required after client activation.',
                      style: AppText.sans(size: 12, color: AppColors.mutedInk, height: 1.55),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Seed users: r.deshmukh · s.iyer · a.patil · admin — password "$seedDevPassword"',
                      style: AppText.mono(size: 10.5, color: AppColors.mutedFainter),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.7));
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.controller, this.obscure = false, this.onSubmit});
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onSubmitted: (_) => onSubmit?.call(),
        style: AppText.sans(size: 14),
        decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
      ),
    );
  }
}
