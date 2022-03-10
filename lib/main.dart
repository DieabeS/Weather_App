import 'package:flutter/material.dart';
import 'package:weather_quiz_app/src/app.dart';

import 'managers/shared_prefernces_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.instance.initialize();

  runApp(const App());
}
