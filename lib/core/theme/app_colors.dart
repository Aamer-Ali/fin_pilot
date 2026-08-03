import 'package:flutter/material.dart';

/// Design-token color palette (FinPilot §2.1, §2.2) and the two
/// [ColorScheme]s derived from it. Widgets should read colors through
/// `Theme.of(context).colorScheme`, never these constants directly.
class AppColors {
  AppColors._();

  // ---- Light mode ----
  static const Color lightPrimary = Color(0xFF000000);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFF131B2E);
  static const Color lightOnPrimaryContainer = Color(0xFF7C839B);
  static const Color lightSecondary = Color(0xFF505F76);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightSecondaryContainer = Color(0xFFD0E1FB);
  static const Color lightOnSecondaryContainer = Color(0xFF54647A);
  static const Color lightTertiary = Color(0xFF000000);
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightTertiaryContainer = Color(0xFF002113);
  static const Color lightOnTertiaryContainer = Color(0xFF009668);
  static const Color lightError = Color(0xFFBA1A1A);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);
  static const Color lightOnErrorContainer = Color(0xFF93000A);
  static const Color lightSurface = Color(0xFFF7F9FB);
  static const Color lightSurfaceBright = Color(0xFFF7F9FB);
  static const Color lightSurfaceDim = Color(0xFFD8DADC);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF2F4F6);
  static const Color lightSurfaceContainer = Color(0xFFECEEF0);
  static const Color lightSurfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color lightSurfaceContainerHighest = Color(0xFFE0E3E5);
  static const Color lightOnSurface = Color(0xFF191C1E);
  static const Color lightOnSurfaceVariant = Color(0xFF45464D);
  static const Color lightOutline = Color(0xFF76777D);
  static const Color lightOutlineVariant = Color(0xFFC6C6CD);
  static const Color lightInverseSurface = Color(0xFF2D3133);
  static const Color lightOnInverseSurface = Color(0xFFEFF1F3);
  static const Color lightInversePrimary = Color(0xFFFFFFFF);
  static const Color lightShadow = Color(0xFF000000);
  static const Color lightScrim = Color(0xFF000000);

  // ---- Dark mode ----
  // Base background per §2.2; elevated surfaces lighten toward #1E293B.
  static const Color darkPrimary = Color(0xFFE8EAED);
  static const Color darkOnPrimary = Color(0xFF0B0F1A);
  static const Color darkPrimaryContainer = Color(0xFF1E293B);
  static const Color darkOnPrimaryContainer = Color(0xFFAEB4C7);
  static const Color darkSecondary = Color(0xFFA9B7CE);
  static const Color darkOnSecondary = Color(0xFF16202E);
  static const Color darkSecondaryContainer = Color(0xFF2E3A4E);
  static const Color darkOnSecondaryContainer = Color(0xFFC7D4E8);
  static const Color darkTertiary = Color(0xFFFFFFFF);
  static const Color darkOnTertiary = Color(0xFF000000);
  static const Color darkTertiaryContainer = Color(0xFF00351F);
  static const Color darkOnTertiaryContainer = Color(0xFF00D68A);
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF690005);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);
  static const Color darkSurface = Color(0xFF020617);
  static const Color darkSurfaceBright = Color(0xFF1E293B);
  static const Color darkSurfaceDim = Color(0xFF020617);
  static const Color darkSurfaceContainerLowest = Color(0xFF01040B);
  static const Color darkSurfaceContainerLow = Color(0xFF0B1120);
  static const Color darkSurfaceContainer = Color(0xFF111827);
  static const Color darkSurfaceContainerHigh = Color(0xFF1A2333);
  static const Color darkSurfaceContainerHighest = Color(0xFF1E293B);
  static const Color darkOnSurface = Color(0xFFE2E5E9);
  static const Color darkOnSurfaceVariant = Color(0xFFC3C6CF);
  static const Color darkOutline = Color(0xFF8D9199);
  static const Color darkOutlineVariant = Color(0xFF43474E);
  static const Color darkInverseSurface = Color(0xFFE2E5E9);
  static const Color darkOnInverseSurface = Color(0xFF2D3133);
  static const Color darkInversePrimary = Color(0xFF000000);
  static const Color darkShadow = Color(0xFF000000);
  static const Color darkScrim = Color(0xFF000000);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    primaryContainer: lightPrimaryContainer,
    onPrimaryContainer: lightOnPrimaryContainer,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    secondaryContainer: lightSecondaryContainer,
    onSecondaryContainer: lightOnSecondaryContainer,
    tertiary: lightTertiary,
    onTertiary: lightOnTertiary,
    tertiaryContainer: lightTertiaryContainer,
    onTertiaryContainer: lightOnTertiaryContainer,
    error: lightError,
    onError: lightOnError,
    errorContainer: lightErrorContainer,
    onErrorContainer: lightOnErrorContainer,
    surface: lightSurface,
    onSurface: lightOnSurface,
    surfaceBright: lightSurfaceBright,
    surfaceDim: lightSurfaceDim,
    surfaceContainerLowest: lightSurfaceContainerLowest,
    surfaceContainerLow: lightSurfaceContainerLow,
    surfaceContainer: lightSurfaceContainer,
    surfaceContainerHigh: lightSurfaceContainerHigh,
    surfaceContainerHighest: lightSurfaceContainerHighest,
    onSurfaceVariant: lightOnSurfaceVariant,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,
    inverseSurface: lightInverseSurface,
    onInverseSurface: lightOnInverseSurface,
    inversePrimary: lightInversePrimary,
    shadow: lightShadow,
    scrim: lightScrim,
    // Explicitly disabled: our surfaceContainer* tokens already encode
    // elevation, so Material's automatic elevation tint would muddy them.
    surfaceTint: Colors.transparent,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    primaryContainer: darkPrimaryContainer,
    onPrimaryContainer: darkOnPrimaryContainer,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    secondaryContainer: darkSecondaryContainer,
    onSecondaryContainer: darkOnSecondaryContainer,
    tertiary: darkTertiary,
    onTertiary: darkOnTertiary,
    tertiaryContainer: darkTertiaryContainer,
    onTertiaryContainer: darkOnTertiaryContainer,
    error: darkError,
    onError: darkOnError,
    errorContainer: darkErrorContainer,
    onErrorContainer: darkOnErrorContainer,
    surface: darkSurface,
    onSurface: darkOnSurface,
    surfaceBright: darkSurfaceBright,
    surfaceDim: darkSurfaceDim,
    surfaceContainerLowest: darkSurfaceContainerLowest,
    surfaceContainerLow: darkSurfaceContainerLow,
    surfaceContainer: darkSurfaceContainer,
    surfaceContainerHigh: darkSurfaceContainerHigh,
    surfaceContainerHighest: darkSurfaceContainerHighest,
    onSurfaceVariant: darkOnSurfaceVariant,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,
    inverseSurface: darkInverseSurface,
    onInverseSurface: darkOnInverseSurface,
    inversePrimary: darkInversePrimary,
    shadow: darkShadow,
    scrim: darkScrim,
    surfaceTint: Colors.transparent,
  );
}
