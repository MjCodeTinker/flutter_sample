import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/DesktopView.dart';

void main() => runApp(FirstFlutterApp());

class FirstFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "default title",
      home: DesktopView(),
    );
  }
}
