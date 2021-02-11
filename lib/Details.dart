import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:memeapp/Generatedmeme.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter_android_downloader/flutter_android_downloader.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
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
  bool ismemegenerated = false;

  @override
  Widget build(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isloading)
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Card(
                    elevation: 10.0,
                    margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                    child: CachedNetworkImage(
                      imageUrl: imageurl,
                      height: 250,
                      width: 300,
                      fit: BoxFit.fill,
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
                    elevation: 10.0,
                    margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                    child: CachedNetworkImage(
                      imageUrl: this.widget.url,
                      height: 250,
                      width: 300,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: text1,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Please Enter First Text"),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: text2,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Please Enter Second  Text"),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                onPressed: () => {generatememe(this.widget.id)},
                child: Text(
                  "Click to Generate Meme",
                  style: TextStyle(fontFamily: 'Raleway-Bold'),
                ),
                color: Colors.redAccent,
                textColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () => {
                        ismemegenerated
                            ? Share.share(imageurl,
                                subject: " subject",
                                sharePositionOrigin:
                                    box.localToGlobal(Offset.zero) & box.size)
                            : Fluttertoast.showToast(
                                msg: "Please Generate Meme First",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 10,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                      },
                      child: Text(
                        "Share",
                        style: TextStyle(fontFamily: 'Raleway-Bold'),
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                    FlatButton(
                        onPressed: () => {
                              ismemegenerated
                                  ? launched(imageurl)
                                  : Fluttertoast.showToast(
                                      msg: "Please Generate Meme  First",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 10,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                            },
                        child: Text("View",
                            style: TextStyle(fontFamily: 'Raleway-Bold')),
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Generatememe> generatememe(String id) async {
    Response response;
    Dio dio = new Dio();
    var url = "https://api.imgflip.com/caption_image";
    if (text1.text.toString().isEmpty || text2.text.toString().isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
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
        ismemegenerated = true;
      });
    }
  }

  launched(String imageurl) async {
    if (await canLaunch(imageurl)) {
      await launch(imageurl);
    } else {
      throw 'Could not launch $imageurl';
    }
  }
}
