// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
          ),
          body: const MyStatelessWidget(),
        ));
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        const Text(
          'Hello world!!!',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
        ),
        const Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: '你好，',
                  style: TextStyle(fontSize: 25, color: Colors.blue)),
              TextSpan(
                  text: 'Geekr',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blueGrey)),
            ],
          ),
        ),
        FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: 'https://image.gstatics.cn/2023/02/09/flutter.gif',
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
            onPressed: () => print('FloatingActionButton pressed'),
            child: Row(
              children: const <Widget>[Icon(Icons.add), Text('Add')],
            )),
        ElevatedButton(
            onPressed: () => print('ElevatedButton pressed'),
            child: const Text('Button')),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => print('TextButton pressed'),
            child: const Text('TextButton')),
      ],
    ));
  }
}

void main() => runApp(const MyApp());
