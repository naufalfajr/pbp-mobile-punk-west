import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:punkwest/cari.dart';
import 'package:punkwest/kategori.dart';
import 'package:punkwest/recentPost.dart';
import './Detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punk West',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Punk West'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  Future<List> getPost() async {
    final response =
        await http.get("https://punkwest.000webhostapp.com/api/get_post.php");
    return json.decode(response.body);
  }

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new TabBarView(
          controller: controller,
          children: [new RecentPost(), new Kategori(), new Cari()]),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(controller: controller, tabs: [
          new Tab(
            icon: new Icon(Icons.recent_actors),
            text: "Recent Post",
          ),
          new Tab(
            icon: new Icon(Icons.category),
            text: "Kategory",
          ),
          new Tab(
            icon: new Icon(Icons.search),
            text: "Search",
          ),
        ]),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  final List list;
  PostList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['judul']),
                leading: new Image(
                    width: 100.0,
                    image: new NetworkImage(
                        "https://punkwest.000webhostapp.com/imgs/" +
                            list[i]['gambar'])),
                subtitle: new Text("Uploaded ${list[i]['tgl_insert']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
