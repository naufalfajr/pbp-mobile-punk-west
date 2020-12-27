import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:punkwest/list_kategori.dart';

import 'dart:convert';
import 'dart:async';

// class Kategori extends StatefulWidget {
//   @override
//   _KategoriState createState() => _KategoriState();
// }

// class _KategoriState extends State<Kategori> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: new Text("hello world"),
//     );
//   }
// }

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori>
    with SingleTickerProviderStateMixin {
  TabController controller;

  Future<List> getPost() async {
    final response =
        await http.get("https://punkwest.000webhostapp.com/api/get_kat.php");
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
    return new Container(
      child: new FutureBuilder<List>(
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
                builder: (BuildContext context) => new ListKategori(
                      namakategori: list[i]['nama'],
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama']),
              ),
            ),
          ),
        );
      },
    );
  }
}
