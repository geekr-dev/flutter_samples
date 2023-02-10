// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const MyHomePage2(title: 'Home Page'),
    ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.yellow,
            height: 80, // 则宽度会自动填充
          ),
        ),
        Container(
          color: Colors.red,
          width: 100,
          height: 180,
        ),
        Container(
          color: Colors.black,
          width: 60,
          height: 80,
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            height: 80, // 宽度会自动填充
          ),
        ),
      ],
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.yellow,
          width: 300,
          height: 300,
        ),
        Positioned(
          left: 18,
          top: 18,
          child: Container(
            color: Colors.green,
            width: 50,
            height: 50,
          ),
        ),
        const Positioned(left: 18, top: 70, child: Text('Stack提供了层叠布局的容')),
      ],
    );
  }
}

void main() => runApp(const MyApp());
