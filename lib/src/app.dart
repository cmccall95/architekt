import 'package:flutter/material.dart';
import 'package:arkitekt/src/components/blueprints_reader.dart';
import 'package:arkitekt/src/components/pre_load_page.dart';

class App extends StatefulWidget {
  static Future<void> initializeAndRun() async {
    return runApp(App());
  }

  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PreLoadPage(),
    );
  }
}
