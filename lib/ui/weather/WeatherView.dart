import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WeatherView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeatherView();
  }
}

class _WeatherView extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(url: "http://m.tianqi.sogou.com/?fr=0005-003q");
  }
}
