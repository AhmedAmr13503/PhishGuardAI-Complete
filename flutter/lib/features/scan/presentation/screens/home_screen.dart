import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../cubit/scan_cubit.dart';
import '../../cubit/scan_state.dart';
import '../widgets/glass_panel.dart';
import '../widgets/phishguard_logo.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  String? _validateUrl(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter a URL to scan';
    final uri = Uri.tryParse(v);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return 'Enter a valid URL (e.g. https://example.com)';
    }
    return null;
  }

  void _onScan(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<ScanCubit>().scanUrl(_urlController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<ScanCubit, ScanState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => ResultScreen(scanResult: result),
              ),
            )
                .then((_) {
              if (!mounted) return;
              _urlController.clear();
              _formKey.currentState?.reset();
            });
            context.read<ScanCubit>().reset();
          },
          failure: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 5),
              ),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PhishGuardLogo(size: 56),
              const SizedBox(width: 10),
              Text(
                'PhishGuard',
                style: theme.appBarTheme.titleTextStyle ??
                    theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroHeader(colorScheme: colorScheme, theme: theme),
                  const SizedBox(height: 28),
                  _buildUrlCard(context, theme, colorScheme),
                  const SizedBox(height: 20),
                  BlocBuilder<ScanCubit, ScanState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
                      return _ScanGradientButton(
                        isLoading: isLoading,
                        onPressed: isLoading ? null : () => _onScan(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUrlCard(BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final fieldRadius = BorderRadius.circular(AppShapes.radiusSm);
    const white = Colors.white;

    OutlineInputBorder glassFieldBorder({double width = 1.5}) {
      return OutlineInputBorder(
        borderRadius: fieldRadius,
        borderSide: BorderSide(color: white, width: width),
      );
    }

    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link_rounded, size: 22, color: white.withOpacity(0.95)),
              const SizedBox(width: 8),
              Text(
                'Paste a link',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            autocorrect: false,
            style: theme.textTheme.bodyLarge?.copyWith(color: white),
            cursorColor: white,
            decoration: InputDecoration(
              labelText: 'URL',
              hintText: 'https://example.com/page',
              labelStyle: TextStyle(color: white.withOpacity(0.88)),
              floatingLabelStyle: const TextStyle(color: white, fontWeight: FontWeight.w500),
              hintStyle: TextStyle(color: white.withOpacity(0.45)),
              prefixIcon: Icon(Icons.language_rounded, color: white.withOpacity(0.88)),
              filled: true,
              fillColor: white.withOpacity(0.08),
              enabledBorder: glassFieldBorder(),
              focusedBorder: glassFieldBorder(width: 2),
              disabledBorder: glassFieldBorder(),
              errorBorder: OutlineInputBorder(
                borderRadius: fieldRadius,
                borderSide: BorderSide(color: colorScheme.error, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: fieldRadius,
                borderSide: BorderSide(color: colorScheme.error, width: 2),
              ),
              errorStyle: theme.textTheme.bodySmall?.copyWith(color: colorScheme.error),
            ),
            validator: _validateUrl,
            onFieldSubmitted: (_) => _onScan(context),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.colorScheme, required this.theme});

  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.radiusLg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.88),
            colorScheme.secondary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Phishing protection for every link',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.95),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Check a link before you open it',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ScanGradientButton extends StatelessWidget {
  const _ScanGradientButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final radius = BorderRadius.circular(AppShapes.radiusMd);

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.green,
        Colors.green.shade500,
      ],
    );

    return Material(
      elevation: onPressed == null ? 0 : 3,
      shadowColor: colorScheme.primary.withOpacity(0.45),
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Ink(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: onPressed == null ? null : gradient,
            color: onPressed == null ? colorScheme.surfaceVariant.withOpacity(0.9) : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colorScheme.primary,
                    ),
                  )
                else
                  Icon(
                    Icons.radar_rounded,
                    color: onPressed == null ? colorScheme.onSurfaceVariant : Colors.white,
                    size: 22,
                  ),
                const SizedBox(width: 10),
                Text(
                  isLoading ? 'Scanning…' : 'Scan URL',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: onPressed == null ? colorScheme.onSurfaceVariant : Colors.white,
                    letterSpacing: 0.6,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
