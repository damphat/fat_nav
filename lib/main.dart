import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool show2ndPage = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onPopPage: (route, dynamic) {
          setState(() {
            show2ndPage = !show2ndPage;
          });
          return false;
        },
        pages: [
          MaterialPage(
            child: Scaffold(
              appBar: AppBar(
                title: Text('one'),
              ),
              body: TextButton(
                child: Text('toggle'),
                onPressed: () {
                  setState(() {
                    show2ndPage = !show2ndPage;
                  });
                },
              ),
            ),
          ),
          if (show2ndPage)
            MaterialPage(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('two'),
                ),
                body: TextButton(
                  child: Text('toggle'),
                  onPressed: () {
                    setState(() {
                      show2ndPage = !show2ndPage;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
