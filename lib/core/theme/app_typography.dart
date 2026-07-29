import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Inter-based type scale (FinPilot §2.3). Styles are colorless — apply
/// color via `.copyWith(color: ...)` from the active [ColorScheme].
class AppTypography {
  AppTypography._();

  static TextStyle get displayLg => GoogleFonts.inter(
    fontSize: 48,
    height: 1.1,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.02 * 48,
  );

  static TextStyle get headlineLg => GoogleFonts.inter(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01 * 32,
  );

  static TextStyle get headlineLgMobile => GoogleFonts.inter(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01 * 24,
  );

  static TextStyle get headlineMd => GoogleFonts.inter(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodyLg => GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bodySm => GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );

  /// Field labels / table headers / category tags. Render the string in
  /// UPPERCASE at the call site — this style does not transform case.
  static TextStyle get labelMd => GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.05 * 12,
  );

  /// All financial figures. Tabular figures keep digit columns aligned.
  static TextStyle get dataMono => GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle get appBarTitle => GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle get appBarBoldTitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextTheme textTheme({
    required Color onSurface,
    required Color onSurfaceVariant,
  }) {
    return TextTheme(
      displayLarge: displayLg.copyWith(color: onSurface),
      headlineLarge: headlineLg.copyWith(color: onSurface),
      headlineMedium: headlineMd.copyWith(color: onSurface),
      titleLarge: headlineLgMobile.copyWith(color: onSurface),
      titleMedium: headlineMd.copyWith(color: onSurface),
      bodyLarge: bodyLg.copyWith(color: onSurface),
      bodyMedium: bodyLg.copyWith(color: onSurface),
      bodySmall: bodySm.copyWith(color: onSurfaceVariant),
      labelLarge: labelMd.copyWith(color: onSurface),
      labelMedium: labelMd.copyWith(color: onSurfaceVariant),
      labelSmall: labelMd.copyWith(color: onSurfaceVariant),
    );
  }
}

/// Theme-aware access to the raw tokens that don't map onto a standard
/// [TextTheme] role (e.g. `dataMono`). Read via
/// `Theme.of(context).extension<AppTextStyles>()!`.
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.displayLg,
    required this.headlineLg,
    required this.headlineLgMobile,
    required this.headlineMd,
    required this.bodyLg,
    required this.bodySm,
    required this.labelMd,
    required this.dataMono,
  });

  factory AppTextStyles.fromColors({
    required Color onSurface,
    required Color onSurfaceVariant,
  }) {
    return AppTextStyles(
      displayLg: AppTypography.displayLg.copyWith(color: onSurface),
      headlineLg: AppTypography.headlineLg.copyWith(color: onSurface),
      headlineLgMobile: AppTypography.headlineLgMobile.copyWith(
        color: onSurface,
      ),
      headlineMd: AppTypography.headlineMd.copyWith(color: onSurface),
      bodyLg: AppTypography.bodyLg.copyWith(color: onSurface),
      bodySm: AppTypography.bodySm.copyWith(color: onSurfaceVariant),
      labelMd: AppTypography.labelMd.copyWith(color: onSurfaceVariant),
      dataMono: AppTypography.dataMono.copyWith(color: onSurface),
    );
  }

  final TextStyle displayLg;
  final TextStyle headlineLg;
  final TextStyle headlineLgMobile;
  final TextStyle headlineMd;
  final TextStyle bodyLg;
  final TextStyle bodySm;
  final TextStyle labelMd;
  final TextStyle dataMono;

  @override
  AppTextStyles copyWith({
    TextStyle? displayLg,
    TextStyle? headlineLg,
    TextStyle? headlineLgMobile,
    TextStyle? headlineMd,
    TextStyle? bodyLg,
    TextStyle? bodySm,
    TextStyle? labelMd,
    TextStyle? dataMono,
  }) {
    return AppTextStyles(
      displayLg: displayLg ?? this.displayLg,
      headlineLg: headlineLg ?? this.headlineLg,
      headlineLgMobile: headlineLgMobile ?? this.headlineLgMobile,
      headlineMd: headlineMd ?? this.headlineMd,
      bodyLg: bodyLg ?? this.bodyLg,
      bodySm: bodySm ?? this.bodySm,
      labelMd: labelMd ?? this.labelMd,
      dataMono: dataMono ?? this.dataMono,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      headlineLg: TextStyle.lerp(headlineLg, other.headlineLg, t)!,
      headlineLgMobile: TextStyle.lerp(
        headlineLgMobile,
        other.headlineLgMobile,
        t,
      )!,
      headlineMd: TextStyle.lerp(headlineMd, other.headlineMd, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      labelMd: TextStyle.lerp(labelMd, other.labelMd, t)!,
      dataMono: TextStyle.lerp(dataMono, other.dataMono, t)!,
    );
  }
}
