import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imgurl;

  ImageView({@required this.imgurl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget.imgurl,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                widget.imgurl,
                fit: BoxFit.cover,
              )),
        ),
//        Container(
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
//          alignment: Alignment.bottomCenter,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              GestureDetector(
//                onTap: (){
//                  _save();
//                },
//                child: Container(
//                  width: MediaQuery.of(context).size.width /2,
//                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(30),
//                    border: Border.all(color: Colors.white60,width: 1),
//                      gradient: LinearGradient(
//                          colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)])),
//                  child: Column(
//                    children: <Widget>[
//                      Text("Set WallPaper" ,style: TextStyle(fontSize: 16,color: Colors.white70),),
//                      Text("Save Img in Gallary",style: TextStyle(fontSize: 10,color: Colors.white70))
//                    ],),),
//              ),
//              SizedBox(height: 16,),
//              Text(
//                "Cancel",
//                style: TextStyle(color: Colors.white,fontSize: 12),
//              ),
//              SizedBox(
//                height: 50,
//              )
//            ],
//          ),
//        ),
      ],
    );
  }
//  _save() async {
//    var response = await Dio().get(widget.imgurl,
//        options: Options(responseType: ResponseType.bytes));
//    final result =
//    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//    print(result);
//    Navigator.pop(context);
//  }

}
