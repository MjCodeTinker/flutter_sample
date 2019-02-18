import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/movie/MovieView.dart';
import 'package:flutter_sample/ui/technology/TechnologyArticleView.dart';
import 'package:flutter_sample/ui/technology/TechnicianRestView.dart';
import 'package:flutter_sample/ui/technology/TechnicianTripView.dart';
import 'package:flutter_sample/ui/weather/WeatherView.dart';

// 当前页面的下标
int currentIndex = 0;

//home
var homeView;

//movie
var movieView;

//weather
var weatherView;

// 存放标题的数组
var titles = [Text("技术"), Text("电影"), Text("天气")];

// 底部导航栏，按钮
var bottomNavigation = [
  BottomNavigationBarItem(icon: Icon(Icons.home), title: titles[0]),
  BottomNavigationBarItem(icon: Icon(Icons.movie), title: titles[1]),
  BottomNavigationBarItem(icon: Icon(Icons.access_time), title: titles[2]),
];

// 第一个导航页面，顶部的指示器tab
var tabBar = TabBar(tabs: [
  Tab(icon: Icon(Icons.airline_seat_flat)),
  Tab(icon: Icon(Icons.airline_seat_legroom_normal)),
  Tab(icon: Icon(Icons.airplanemode_active)),
]);

class DesktopView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 创建桌面view
    return MainView();
  }
}

class MainView extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bottomNavigation.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: titles[currentIndex],
          bottom: currentIndex == 0 ? tabBar : null,
        ),
        drawer: Drawer(
          elevation: 8.0,
          semanticLabel: '滑动抽屉',
          child: DrawerLayout(),
        ),
        body: _getBody(),
//            Stack(
//          children: <Widget>[
//            _getBody(0),
//            _getBody(1),
//            _getBody(2),
//          ],
//        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _tabClick,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: bottomNavigation,
        ),
      ),
    );
  }

  /*
   底部 tab 点击切换
   */
  _tabClick(int index) {
    if (currentIndex == index) {
      return;
    }
    setState(() {
      currentIndex = index;
    });
  }

  /*
   页面显示的内容
   */
  _getBody() {
    switch (currentIndex) {
      case 0:
        if (homeView == null) {
          homeView = TabBarView(
            children: <Widget>[
              TechnologyArticleView(),
              TechnicianRestView(),
              TechnicianTripView()
            ],
          );
        }
//        return Offstage(
//          offstage: currentIndex != index,
//          child: TickerMode(
//            enabled: currentIndex == index,
//            child: homeView,
//          ),
//        );
        return homeView;
      case 1:
        if (movieView == null) {
          movieView = MovieView();
        }
//        return Offstage(
//          offstage: currentIndex != index,
//          child: TickerMode(
//            enabled: currentIndex == index,
//            child: movieView,
//          ),
//        );
        return movieView;
      case 2:
        if (weatherView == null) {
          weatherView = WeatherView();
        }
//        return Offstage(
//          offstage: currentIndex != index,
//          child: TickerMode(enabled: currentIndex ==index,child: weatherView,),
//        );
        return weatherView;
    }
  }
}

// 抽屉
class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: new BoxDecoration(
            color: Colors.grey[400],
          ),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: new Column(
                    children: <Widget>[
                      new CircleAvatar(
                        child: new Text('R'),
                      ),
                      new Text('MiaoJian',
                          style: Theme.of(context).textTheme.title),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        new AboutListTile(
          icon: new Icon(Icons.person),
          child: new Text('关于项目'),
          applicationLegalese: '',
          applicationName: 'Flutter Sample',
          applicationVersion: 'version:1.0',
        ),
      ],
    );
  }
}
