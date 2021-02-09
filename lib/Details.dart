import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memeapp/Generatedmeme.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(new MaterialApp(
    home: Detai(),
  ));
}

class Detai extends StatefulWidget {
  String url, id;

  Detai({this.url, this.id});

  @override
  _DetaiState createState() => _DetaiState();
}

class _DetaiState extends State<Detai> {
  var text1 = TextEditingController();
  var text2 = TextEditingController();
  bool _isloading = false;
  bool visible = true;
  Data _generatememe;
  String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            if (_isloading)
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Card(
                  child: CachedNetworkImage(
                    imageUrl: imageurl,
                    height: 250,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            Visibility(
              visible: visible,
              child: Padding(

                padding: const EdgeInsets.all(28.0),
                child: Card(

                  child: CachedNetworkImage(
                    imageUrl: this.widget.url,
                    height: 250,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: text1,
                style: TextStyle(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "please enter first text"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: text2,
                style: TextStyle(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "please enter second  text"),
              ),
            ),

            FlatButton(
              onPressed: () => {generatememe(this.widget.id)},
              child: Text("click to generate meme"),
              color: Colors.redAccent,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Future<Generatememe> generatememe(String id) async {
    Response response;
    Dio dio = new Dio();
    var url = "https://api.imgflip.com/caption_image";
    FormData formData = new FormData.fromMap({
      "template_id": this.widget.id,
      "username": "ashrafmakandar",
      "password": "ashraf1234",
      "text0": text1.text.toString(),
      "text1": text2.text.toString()
    });
    response = await dio.post(url, data: formData);
    print("daara" + response.data.toString());
    setState(() {
      _isloading = true;
      visible = false;
      _generatememe =
          Generatememe.fromJson(json.decode(response.toString())).data;
      imageurl = _generatememe.url.toString();
    });
  }
}
