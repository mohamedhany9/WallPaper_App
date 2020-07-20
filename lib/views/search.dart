import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallPaperModel> wallpaper = new List();
  TextEditingController searchController = new TextEditingController();

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
    getSearchingWallPaper(widget.searchQuery);
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
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchingWallPaper(searchController.text);
                      },
                      child: Container(child: Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              wallpapersList(wallpapers: wallpaper, context: context),
            ]),
          ),
        ));
  }
}
