import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  final String indexPage;
  const MyPage({Key key, this.indexPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterDemo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: _rootPage(indexPage),
    );
  }

  Widget _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Center(
            child: Text(pageIndex),
          ),
        );
        break;
      case 'two':
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex)),
          body: Center(child: Text(pageIndex)),
        );
        break;
      default:
        return Scaffold(
          appBar: AppBar(title: Text('default')),
          body: Center(child: Text('default')),
        );
        break;
    }
  }
}
