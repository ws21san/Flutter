import 'dart:math';

import 'package:flutter/material.dart';

class KeyDemo extends StatefulWidget {
  @override
  _KeyDemoState createState() => _KeyDemoState();
}

class _KeyDemoState extends State<KeyDemo> {
  List<Widget> items = [
    StfulItem(
      'aaa',
      key: ValueKey('1111'),
    ),
    StfulItem(
      'bbb',
      key: ObjectKey(Text(('222'))),
    ),
    StfulItem(
      'ccc',
      key: UniqueKey(), //保证key的唯一性
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Key demo'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            if (items.length > 0) {
              items.removeAt(0);
            }
          });
        },
      ),
    );
  }
}

class StfulItem extends StatefulWidget {
  final title;
  StfulItem(this.title, {Key key}) : super(key: key);

  @override
  _StfulItemState createState() => _StfulItemState();
}

class _StfulItemState extends State<StfulItem> {
  final _color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(widget.title),
    );
  }
}

class StlItem extends StatelessWidget {
  final title;
  StlItem(this.title);
  final _color = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: _color,
      child: Text(title),
    );
  }
}
