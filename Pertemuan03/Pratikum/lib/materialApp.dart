import 'package:flutter/material.dart';
import 'package:flutter_project_belajar/materialPage.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: false),
      home: HomePage(),
    );
  }
}
