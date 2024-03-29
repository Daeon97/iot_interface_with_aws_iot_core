import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_interface_with_aws_iot_core/app.dart';
import 'package:iot_interface_with_aws_iot_core/injection_container.dart';

void main() {
  _initializeImportantResources().then(
    (_) => runApp(
      const App(),
    ),
  );
}

Future<void> _initializeImportantResources() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  await dotenv.load();
}


