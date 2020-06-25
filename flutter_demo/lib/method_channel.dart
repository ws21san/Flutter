import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemo extends StatefulWidget {
  @override
  _MethodChannelState createState() => _MethodChannelState();
}

class _MethodChannelState extends State<MethodChannelDemo> {
  MethodChannel _methodChannel = MethodChannel('MethodChannelDemo');
  File _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel.setMethodCallHandler((handler) {
      if (handler.method == 'imagePath') {
        String imagePath = handler.arguments.toString().substring(7);
        setState(() {
          _imageFile = File(imagePath);
        });
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('methodChannel'),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            width: 100,
            height: 100,
            child: Image(
                image: _imageFile == null
                    ? AssetImage('images/badge.png')
                    : FileImage(_imageFile)),
          ),
          onTap: () {
            _methodChannel.invokeMapMethod('chooseImage', 'photo');
          },
        ),
      ),
    );
  }
}
