import 'package:flutter/widgets.dart';

/// Corner radius tokens.
class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;

  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullRadius = BorderRadius.all(
    Radius.circular(full),
  );
}