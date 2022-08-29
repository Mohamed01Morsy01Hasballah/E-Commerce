import 'dart:math';

class CategoryModel{
 late  bool status;
 late  CategoryDataModel data;
  CategoryModel.fromJson(Map<String ,dynamic>json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}
class CategoryDataModel{
  late int current_page;
  List<dataModel> data=[];
  CategoryDataModel.fromJson(Map<String ,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((elements){
      data.add(dataModel.fromJson(elements));
    });
  }
}
class dataModel{
 late int id;
  late String name;
late   String image;
  dataModel.fromJson(Map<String ,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}