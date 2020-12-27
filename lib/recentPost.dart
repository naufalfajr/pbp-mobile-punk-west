import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Detail.dart';

class RecentPost extends StatefulWidget {
  RecentPost({Key key}) : super(key: key);

  @override
  _RecentPostState createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  Future<List> getPost() async {
    final response =
        await http.get("https://punkwest.000webhostapp.com/api/get_post.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new FutureBuilder<List>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new PostList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
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
