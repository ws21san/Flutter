import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp(
//      pageIndex: window.defaultRouteName,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pageIndex = 'one';
  final MethodChannel _oneChannel = MethodChannel('one_page');
  final MethodChannel _twoChannel = MethodChannel('two_page');
  final BasicMessageChannel _messageChannel =
      BasicMessageChannel('messageChannel', StandardMessageCodec());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageChannel.setMessageHandler((message) {
      print('收到了来自iOS的：$message');
      return null;
    });
    _oneChannel.setMethodCallHandler((call) {
      setState(() {
        pageIndex = call.method;
      });
      return null;
    });
    _twoChannel.setMethodCallHandler((call) {
      setState(() {
        pageIndex = call.method;
      });
      return null;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: rootPage(pageIndex),
    );
  }

  Widget rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text(pageIndex),
                  onPressed: () {
                    MethodChannel('one_page').invokeMapMethod('exit');
                  }),
              TextField(
                onChanged: (String str) {
                  _messageChannel.send(str);
                },
              )
            ],
          ),
        );
        break;
      case 'two':
        return Scaffold(
          appBar: AppBar(
            title: Text(pageIndex),
          ),
          body: Center(
            child: RaisedButton(
                child: Text(pageIndex),
                onPressed: () {
                  MethodChannel('two_page').invokeMapMethod('exit');
                }),
          ),
        );
        break;
      default:
        return Scaffold(
          appBar: AppBar(
            title: Text('default'),
          ),
          body: Center(
            child: Text('default'),
          ),
        );
        break;
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
