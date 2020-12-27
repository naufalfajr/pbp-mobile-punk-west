import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Detail.dart';

import 'dart:convert';
import 'dart:async';

class CariPost extends StatefulWidget {
  CariPost({this.teksInput});
  final String teksInput;

  @override
  _CariPostState createState() => _CariPostState();
}

class _CariPostState extends State<CariPost> {
  Future<List> getPost() async {
    var url = "https://punkwest.000webhostapp.com/api/get_cari.php";
    final response = await http.post(url, body: {'cari': widget.teksInput});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.teksInput),
      ),
      body: new FutureBuilder<List>(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new HasilCari(
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

class HasilCari extends StatelessWidget {
  final List list;
  HasilCari({this.list});

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
