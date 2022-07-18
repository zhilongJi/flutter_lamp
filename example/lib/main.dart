import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zhilong_lamp/zhilong_lamp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _zhilongLampPlugin = ZhilongLamp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('手电筒控制'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: _zhilongLampPlugin.turnOn, child: const Text('打开')),
                TextButton(onPressed: _zhilongLampPlugin.turnOff, child: const Text('关闭')),
                TextButton(onPressed: _zhilongLampPlugin.toggle, child: const Text('切换')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
