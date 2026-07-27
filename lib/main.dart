import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injector.dart';

void main() {
  setupInjector();
  runApp(const App());
}