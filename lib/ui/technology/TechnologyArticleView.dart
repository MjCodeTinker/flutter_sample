import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_sample/net/HttpUtils.dart';
import 'package:flutter_sample/data/ArticleBean.dart';

class TechnologyArticleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TechnologyArticle();
  }
}

class _TechnologyArticle extends State<TechnologyArticleView>
    with AutomaticKeepAliveClientMixin {
  List<Content> data = List();

  // listView的滑动控制器
  ScrollController _scrollController = ScrollController();

  //是否正在加载中
  bool isLoading = false;

  //分页夹在的页数
  int _pageSize = 0;

  @override
  void initState() {
    super.initState();
    initListener();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemBuilder: renderRow,
        itemCount: data.length + 1,
        controller: _scrollController,
      ),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index < data.length) {
      if (index.isOdd) {
        return Divider();
      }
      return Container(
          child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(data[index].chapterName),
          leading: Image(
            width: 120,
            height: 70,
            image: NetworkImage(data[index].envelopePic),
            fit: BoxFit.fill,
          ),
          subtitle: Text(
            data[index].desc,
            maxLines: 3,
          ),
        ),
      ));
    }
    return _getMoreWidget();
  }

  /*
    加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RefreshProgressIndicator(
              strokeWidth: 2.0,
            ),
            Text(
              '加载中... ',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void initListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到底部了，开始加载更多pageSize = $_pageSize');
        _loadMore();
      }
    });
  }

  // 刷新数据,此处有坑，必须要返回一个Future 对象
  Future _refreshData() async {
    _pageSize = 0;
    var response = await ArticleNet().loadData(_pageSize);
    ArticleBean articleBean = ArticleBean.parseJson(json.decode(response));
    if (articleBean.errorCode == 0) {
      setState(() {
        this.data = articleBean.contentBody.dataList;
      });
    }
  }

  /*
   加载更多
   */
  _loadMore() async {
    if (!isLoading) {
      setState(() {
        _pageSize++;
        isLoading = true;
      });
      var response = await ArticleNet().loadData(_pageSize);
      ArticleBean articleBean = ArticleBean.parseJson(json.decode(response));
      if (articleBean.errorCode == 0) {
        setState(() {
          this.data.addAll(articleBean.contentBody.dataList);
          isLoading = false;
        });
      } else {
        if (_pageSize > 0) {
          _pageSize--;
        }
      }
    }
  }
}
