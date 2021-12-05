import 'package:flutter/material.dart';
import 'package:miseo/app/dependency_injection.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
