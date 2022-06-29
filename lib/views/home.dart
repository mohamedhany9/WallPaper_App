import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoriesModel> categories = new List();
  List<WallPaperModel> wallpaper = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallPaper(String query) async
  {
    var response = await http.get("https://api.pexels.com/v1/${query}?per_page=15&page=1",
        headers:{
        "Authorization" : apiKey});

    Map<String , dynamic> jsondata = jsonDecode(response.body);
    jsondata["photos"].forEach((elememt){
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
    getTrendingWallPaper("curated");
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30)
                ),
                padding:EdgeInsets.symmetric(horizontal: 20) ,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Search(
                            searchQuery: searchController.text,
                          )
                        ));
                      },
                      child: Container(
                          child: Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Container(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                    itemBuilder: (context , index){
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                    }
                ),
              ),
              wallpapersList(wallpapers: wallpaper , context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl , title;

  CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Category(
            categoryname: title.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl,height: 60, width: 100, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26
              ),
            height: 60, width: 100,
              alignment: Alignment.center,
              child: Text(title,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}
