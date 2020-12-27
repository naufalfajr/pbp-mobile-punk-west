import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String isKomentarNull() {
    String isiKomentar;
    if ("${widget.list[widget.index]['isi']}" == "null") {
      isiKomentar = "Belum Ada Komentar";
      return isiKomentar;
    } else {
      isiKomentar = "${widget.list[widget.index]['isi']}";
      return isiKomentar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar:
          new AppBar(title: new Text("${widget.list[widget.index]['judul']}")),
      body: new SingleChildScrollView(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Image(
                      image: new NetworkImage(
                          "https://punkwest.000webhostapp.com/imgs/" +
                              widget.list[widget.index]['gambar'])),
                  new Text(
                    "Oleh : ${widget.list[widget.index]['nama']}",
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  new Divider(
                    indent: 10.0,
                    endIndent: 10.0,
                    thickness: 3.0,
                    height: 30.0,
                  ),
                  new Text(
                    widget.list[widget.index]['isi_post'],
                    style: new TextStyle(fontSize: 18.0),
                  ),
                  new Container(
                      padding: EdgeInsets.all(15.0),
                      child: new Card(
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          new Text(
                            "Komentar",
                            style: new TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          new Divider(
                            indent: 5.0,
                            endIndent: 5.0,
                            thickness: 2.0,
                            height: 10.0,
                          ),
                          new Text(
                            isKomentarNull(),
                          ),
                        ],
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
