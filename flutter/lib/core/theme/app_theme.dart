import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared layout tokens for consistent UI (screens may import for one-off use).
abstract final class AppShapes {
  static const double radiusXs = 10;
  static const double radiusSm = 14;
  static const double radiusMd = 18;
  static const double radiusLg = 22;
}

class AppTheme {
  /// Brand navy — primary surfaces, app bars, key actions.
  static const Color backgroundColor = Color(0xFF03264A);

  static const Color _pageBackground = Color(0xFFF5F8FC);
  static const Color _secondary = Color(0xFF0B4A7A);
  static const Color errorColor = Color(0xFFB91C1C);

  /// Single app theme (light “normal” mode only — no system dark theme).
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: backgroundColor,
      brightness: Brightness.light,
    ).copyWith(
      primary: backgroundColor,
      onPrimary: Colors.white,
      secondary: _secondary,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: const Color(0xFF0F172A),
      surfaceVariant: const Color(0xFFE2E8F0),
      onSurfaceVariant: const Color(0xFF475569),
      background: _pageBackground,
      onBackground: const Color(0xFF0F172A),
      primaryContainer: const Color(0xFFC8D9ED),
      onPrimaryContainer: backgroundColor,
      error: errorColor,
      onError: Colors.white,
      outline: const Color(0xFFCBD5E1),
      shadow: const Color(0x1A0F172A),
    );

    final textTheme = _buildTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      visualDensity: VisualDensity.standard,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shadowColor: colorScheme.shadow,
        surfaceTintColor: Colors.transparent,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusMd),
          side: BorderSide(color: colorScheme.outline.withOpacity(0.35)),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          ),
          textStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          ),
          textStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.65),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.45)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant.withOpacity(0.75),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
        ),
        backgroundColor: backgroundColor,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        actionTextColor: Colors.white,
      ),
      dialogTheme: DialogTheme(
        elevation: 3,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusLg),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withOpacity(0.35),
        thickness: 1,
        space: 1,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusSm),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme scheme) {
    final onSurface = scheme.onSurface;
    final onVariant = scheme.onSurfaceVariant;
    final base = TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.5,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.35,
        color: onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.2,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.1,
        color: onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: 0.05,
        color: onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.35,
        letterSpacing: 0.1,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        letterSpacing: 0.2,
        color: onVariant,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.4,
        letterSpacing: 0.25,
        color: onVariant,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: 0.4,
        color: onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: 0.5,
        color: onVariant,
      ),
    );

    return base.apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );
  }
}
