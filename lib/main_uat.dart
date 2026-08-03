import 'package:fin_pilot/flavour_config.dart';
import 'package:fin_pilot/main_common.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.setUpEnv(Environment.uat);
  mainCommon();
}
