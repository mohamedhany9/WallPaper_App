import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.blue),
      )
    ],
  );
}

Widget wallpapersList({List<WallPaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImageView(
                  imgurl: wallpaper.src.portrait,
                )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                    child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
