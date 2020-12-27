import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Detail.dart';

// ignore: must_be_immutable
class ListKategori extends StatefulWidget {
  final String namakategori;

  ListKategori({this.namakategori});

  @override
  _ListKategoriState createState() => _ListKategoriState();
}

class _ListKategoriState extends State<ListKategori>
    with SingleTickerProviderStateMixin {
  TabController controller;

  Future<List> getPost() async {
    var url = "https://punkwest.000webhostapp.com/api/get_postbykat.php";
    final response = await http.post(url, body: {'nama': widget.namakategori});
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

  void filterKategori() {
    var url = "https://punkwest.000webhostapp.com/api/get_postbykat.php";
    http.post(url, body: {'nama': widget.namakategori});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.namakategori),
      ),
      body: new FutureBuilder<List>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new KatList(
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

class KatList extends StatelessWidget {
  final List list;
  KatList({this.list});

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
