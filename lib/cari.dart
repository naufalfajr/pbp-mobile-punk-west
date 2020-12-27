import 'package:flutter/material.dart';
import 'package:punkwest/cariPost.dart' as caripost;

class Cari extends StatefulWidget {
  @override
  _CariState createState() => _CariState();
}

class _CariState extends State<Cari> {
  String teksInput = "";

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(15.0),
        child: new Column(
          children: [
            new TextField(
              decoration:
                  new InputDecoration(hintText: "Tuliskan Judul yang Dicari"),
              onChanged: (String str) {
                setState(() {
                  teksInput = str;
                });
              },
              onSubmitted: (String str) {
                setState(() {
                  teksInput = str;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => caripost.CariPost(
                              teksInput: teksInput,
                            )));
              },
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            new RaisedButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => caripost.CariPost(
                              teksInput: teksInput,
                            )));
              },
              child: new Text(
                "Cari",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
