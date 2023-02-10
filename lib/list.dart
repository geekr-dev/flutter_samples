// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Home Page'));
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal, // 水平排列（默认垂直排列）
      itemExtent: 140,
      children: const <Widget>[
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
      ],
    );
  }
}

class PianoWidget extends StatelessWidget {
  const PianoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 88,
      itemExtent: 50,
      itemBuilder: (BuildContext context, int index) {
        if (index.isEven) {
          // 偶数
          return Container(color: Colors.black);
        } else {
          return Container(color: Colors.white);
        }
      },
    );
  }
}

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 30,
      separatorBuilder: (BuildContext context, int index) => index.isEven
          ? const Divider(
              color: Colors.red,
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            )
          : const Divider(
              color: Colors.green,
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Post $index'),
          subtitle: Text('This is post $index'),
        );
      },
    );
  }
}

class PostListWithBgImage extends StatelessWidget {
  const PostListWithBgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('CustomScrollView Demo'),
          floating: true,
          flexibleSpace: Image.network(
              'https://image.gstatics.cn/2023/02/09/2023_02_09_image-20230209202819664.webp',
              fit: BoxFit.cover), // 设置顶部图片
          expandedHeight: 200, // 设置顶部图片高度
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('Post $index'),
                subtitle: Text('This is post $index'),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            PostListWithBgImage(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.rss_feed), text: 'Notification'),
            Tab(icon: Icon(Icons.perm_identity), text: 'Controller'),
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}

class ScrollNotificationWidget extends StatelessWidget {
  const ScrollNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Notification Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scroll Notification Demo'),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            // 注册通知回调
            if (notification is ScrollStartNotification) {
              // 滚动开始
              print('开始滚动');
            } else if (notification is ScrollUpdateNotification) {
              // 滚动位置更新
              print('正在滚动');
            } else if (notification is ScrollEndNotification) {
              // 滚动结束
              print('滚动停止');
            }
            return true;
          },
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Index: $index'),
                );
              }),
        ),
      ),
    );
  }
}

class ScrollControllerWidget extends StatefulWidget {
  const ScrollControllerWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScrollControllerWidgetState();
  }
}

class _ScrollControllerWidgetState extends State<StatefulWidget> {
  late ScrollController _controller;
  bool isTop = false; // 当前是否需要显示 Top 按钮

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      // 注册监听滚动事件
      if (_controller.offset > 1000) {
        // 向下滚动距离大于1000，则显示Top按钮
        setState(() {
          isTop = true;
        });
      } else if (_controller.offset < 300) {
        // 向下滚动距离小于300，则隐藏Top按钮
        setState(() {
          isTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Controller Widget'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            child: ElevatedButton(
              // 返回顶部按钮
              onPressed: isTop
                  ? () {
                      if (isTop) {
                        // 滚动到顶部
                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease);
                      }
                    }
                  : null,
              child: const Text('Top'),
            ),
          ),
          Expanded(
              // 列表
              child: ListView.builder(
                  controller: _controller,
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Index: $index'),
                    );
                  })),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 销毁控制器
    _controller.dispose();
    super.dispose();
  }
}

void main() => runApp(const MyApp());
