import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';

abstract final class AppTheme {
  static final lightTheme = _build(Brightness.light);
  static final darkTheme = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final surface = dark ? AppColors.darkSurface : AppColors.lightSurface;
    final elevated = dark ? AppColors.darkElevated : AppColors.lightElevated;
    final text = dark ? AppColors.darkText : AppColors.lightText;
    final muted = dark ? AppColors.darkMuted : AppColors.lightMuted;
    final border = dark ? AppColors.darkBorder : AppColors.lightBorder;
    final controlBorder = dark
        ? AppColors.darkControlBorder
        : AppColors.lightControlBorder;
    final accent = dark ? AppColors.darkAccent : AppColors.lightAccent;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: brightness,
        ).copyWith(
          primary: accent,
          onPrimary: dark ? AppColors.darkBackground : Colors.white,
          surface: surface,
          onSurface: text,
          onSurfaceVariant: muted,
          surfaceContainerHighest: elevated,
          outline: border,
          outlineVariant: border,
        );
    final theme = ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: dark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      fontFamily: 'Manrope',
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      useMaterial3: true,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PortfolioLayout.smallRadius),
    );
    final focus = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.focused))
        return accent.withValues(alpha: .30);
      if (states.contains(WidgetState.pressed))
        return accent.withValues(alpha: .23);
      if (states.contains(WidgetState.hovered))
        return accent.withValues(alpha: .13);
      return null;
    });
    final buttons = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      shape: WidgetStatePropertyAll(shape),
      overlayColor: focus,
      animationDuration: PortfolioLayout.fast,
    );

    final type = theme.textTheme.apply(bodyColor: text, displayColor: text);
    return theme.copyWith(
      textTheme: type.copyWith(
        bodyLarge: type.bodyLarge?.copyWith(
          color: muted,
          fontSize: 16,
          height: 1.58,
          fontVariations: const [FontVariation('wght', 500)],
        ),
        bodyMedium: type.bodyMedium?.copyWith(
          color: muted,
          fontSize: 14,
          height: 1.55,
          fontVariations: const [FontVariation('wght', 500)],
        ),
        titleLarge: type.titleLarge?.copyWith(
          color: text,
          fontSize: 23,
          height: 1.25,
          fontWeight: FontWeight.w800,
          fontVariations: const [FontVariation('wght', 800)],
        ),
        titleMedium: type.titleMedium?.copyWith(
          color: text,
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w700,
          fontVariations: const [FontVariation('wght', 700)],
        ),
        labelLarge: type.labelLarge?.copyWith(
          fontVariations: const [FontVariation('wght', 700)],
        ),
        labelMedium: type.labelMedium?.copyWith(
          fontVariations: const [FontVariation('wght', 650)],
        ),
      ),
      dividerColor: border,
      focusColor: accent.withValues(alpha: .30),
      hoverColor: accent.withValues(alpha: .13),
      filledButtonTheme: FilledButtonThemeData(
        style: buttons.copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused))
              return scheme.onPrimary.withValues(alpha: .25);
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return scheme.onPrimary.withValues(alpha: .15);
            }
            return null;
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttons.copyWith(
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.focused)
                  ? accent
                  : controlBorder,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: buttons.copyWith(foregroundColor: WidgetStatePropertyAll(text)),
      ),
      chipTheme: theme.chipTheme.copyWith(
        backgroundColor: surface,
        selectedColor: elevated,
        side: BorderSide(color: controlBorder),
        checkmarkColor: accent,
        shape: shape,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      ),
    );
  }
}
