import 'package:flutter/material.dart';
import 'package:flutter_sample/net/HttpUtils.dart';
import 'dart:convert';
import 'package:flutter_sample/data/ArticleBean.dart';

class MovieView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieView();
  }
}

class _MovieView extends State<MovieView> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    ArticleNet articleNet = ArticleNet();
    var text = await articleNet.loadData(1);
    ArticleBean articleBean = ArticleBean.parseJson(json.decode(text));
    setState(() {
      this.text = articleBean.toString();
    });
  }
}
