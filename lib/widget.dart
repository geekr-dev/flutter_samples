import 'dart:math';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Update',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.system_update), text: '组合'),
            Tab(icon: Icon(Icons.cake), text: '自绘'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView(
            children: <Widget>[
              UpdateItemWidget(
                model: UpdateItemModel(
                    appIcon: 'assets/google-maps.png',
                    appDescription:
                        'Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.',
                    appName: 'Google Maps - Transit & Fond',
                    appSize: '137.2',
                    appVersion: 'Version 7.19',
                    appDate: '2023年2月11日'),
                onPressed: () {},
              )
            ],
          ),
          const Center(
            child: Cake(),
          )
        ],
      ),
    );
  }
}

class UpdateItemModel {
  // 构造函数语法糖
  UpdateItemModel(
      {this.appIcon,
      this.appName,
      this.appSize,
      this.appDate,
      this.appDescription,
      this.appVersion});
  String? appIcon;
  String? appName;
  String? appSize;
  String? appDate;
  String? appDescription;
  String? appVersion;
}

class UpdateItemWidget extends StatelessWidget {
  const UpdateItemWidget({super.key, this.model, this.onPressed});
  final UpdateItemModel? model;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopRow(context),
        buildButtonRow(context),
      ],
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(model?.appIcon ?? '', width: 80, height: 80))),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              model?.appName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, color: Color(0xFF8E8D92)),
            ),
            Text(
              '${model?.appDate}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Color(0xFF8E8D92)),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'OPEN',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      )
    ]);
  }

  Widget buildButtonRow(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: const Text('立即更新'),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('稍后更新'),
        ),
      ],
    );
  }
}

class Cake extends StatelessWidget {
  const Cake({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WheelPainter(),
      size: const Size(300, 300),
    );
  }
}

class WheelPainter extends CustomPainter {
  //设置画笔颜色
  Paint getColoredPaint(Color color) {
    Paint paint;
    paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //饼图尺寸
    double wheelSize;
    wheelSize = min(size.width, size.height) / 2;
    double nbElem;
    nbElem = 6;
    double radius;
    radius = (2 * pi) / nbElem;
    Rect boundingRect;
    boundingRect = Rect.fromCircle(
        center: Offset(wheelSize, wheelSize), radius: wheelSize);

    //画圆弧，每次1/6个圆弧
    canvas.drawArc(
        boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(
        boundingRect, radius, radius, true, getColoredPaint(Colors.black38));
    canvas.drawArc(
        boundingRect, radius * 2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(
        boundingRect, radius * 3, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(
        boundingRect, radius * 4, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(
        boundingRect, radius * 5, radius, true, getColoredPaint(Colors.pink));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
