import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';

class Category extends StatefulWidget {
  final String categoryname;
  Category({this.categoryname});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<WallPaperModel> wallpaper = new List();

  getSearchingWallPaper(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((elememt) {
      WallPaperModel wallPaperModel = new WallPaperModel();
      wallPaperModel = WallPaperModel.fromMap(elememt);
      wallpaper.add(wallPaperModel);
    });
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchingWallPaper(widget.categoryname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              wallpapersList(wallpapers: wallpaper, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
