// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        onGenerateRoute: _routes,
      );
}

Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
      builder: (_) => Container(),
    );
