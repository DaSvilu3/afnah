
class Category{
  int id;
  String title;
  String icon;
  String info;


  Category({this.id, this.title, this.icon, this.info});
  Map map;
  Category.fromMap(map){
    id = map["id"];
    title = map["title"];
    icon = map["icon"];
    info = map["info"];
  }

  Map toMap(){
    return new Map.from({
      "id" : id,
      "title" : title,
      "icon"  : icon,
      "info"  : info
    });
  }

}