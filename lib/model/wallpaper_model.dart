
class WallPaperModel{

  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallPaperModel(
      {this.photographer, this.photographer_url, this.photographer_id, this.src});

  factory WallPaperModel.fromMap(Map<String, dynamic> parsedJson) {
    return WallPaperModel(
        photographer: parsedJson["photographer"],
        photographer_id: parsedJson["photographer_id"],
        photographer_url: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel{
  String orignal;
  String small;
  String portrait;

  SrcModel({this.orignal, this.small, this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        orignal: srcJson["landscape"],
        small: srcJson["medium"]);
  }
}