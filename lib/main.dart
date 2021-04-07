import 'package:fat_nav/main1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routeInformationParser = MyRouteInfomationParser();
  final routerDelegate = MyRouterDelegate();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate);
  }
}

class MyRouterDelegate extends RouterDelegate<MyPath> {
  List<MyPath> history = [];
  MyPath currentPath;
  Set<Function> listeners = {};

  @override
  void addListener(listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(listener) {
    listeners.remove(listener);
  }

  void notify() {
    for (var listener in listeners) {
      listener();
    }
  }

  @override
  Future<void> setNewRoutePath(MyPath path) async {
    currentPath = path;
  }

  @override
  MyPath get currentConfiguration => currentPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('$currentPath')),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                history.add(currentPath);
                currentPath = MyPathSettings();
                notify();
              },
              child: Text('push settings'),
            ),
            ElevatedButton(
              onPressed: () {
                history.add(currentPath);
                currentPath = MyPathList();
                notify();
              },
              child: Text('push details'),
            ),
            ElevatedButton(
                onPressed: () {
                  if (history.length > 0) {
                    currentPath = history.removeLast();
                    notify();
                  }
                },
                child: Text('pop')),
            ElevatedButton(onPressed: () {}, child: Text('push')),
          ],
        ));
  }

  @override
  Future<bool> popRoute() async {
    return true;
  }
}

class MyRouteInfomationParser extends RouteInformationParser<MyPath> {
  @override
  Future<MyPath> parseRouteInformation(RouteInformation info) async {
    var segs = Uri.parse(info.location).pathSegments;
    if (segs.length < 1) return MyPathRoot();
    if (segs[0] == 'settings') return MyPathSettings();
    if (segs[0] == 'books') {
      if (segs.length == 1) return MyPathList();
      var id = int.tryParse(segs[1]);
      if (id == null) return MyPathList();

      return MyPathDetail(id);
    }

    return MyPathRoot();
  }

  @override
  RouteInformation restoreRouteInformation(MyPath o) {
    if (o is MyPathSettings) return RouteInformation(location: '/settings');
    if (o is MyPathList) return RouteInformation(location: '/books');
    if (o is MyPathDetail) return RouteInformation(location: '/books/${o.id}');
    if (o is MyPathRoot) return RouteInformation(location: '/');
    return null;
  }
}

abstract class MyPath {}

class MyPathRoot extends MyPath {}

class MyPathList extends MyPath {}

class MyPathSettings extends MyPath {}

class MyPathDetail extends MyPath {
  final int id;
  MyPathDetail(this.id);
}
