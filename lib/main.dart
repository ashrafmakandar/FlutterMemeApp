

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memeapp/Details.dart';
import 'package:memeapp/Meme.dart';
import 'package:memeapp/Splash.dart';
import 'package:octo_image/octo_image.dart';
void main() {
  runApp(new MaterialApp(
    home: Splash(),
  ));
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List<Memes> _me;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: _me.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext c)=>Detai(url:_me[index].url,id:_me[index].id))),
                        child: Card(
                          child: CachedNetworkImage(
                            imageUrl: _me[index].url,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

 Future<List<Memes>> getdata() async {
    var url="https://api.imgflip.com/get_memes";
    var response =await http.get(url);

    Meme mes=Meme.fromJson(json.decode(response.body));
setState(() {

  _me=mes.data.memes;
});
return _me;

    
  }
}
