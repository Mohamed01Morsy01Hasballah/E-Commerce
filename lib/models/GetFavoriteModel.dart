class GetFavoriteModel{
  bool? status;
  GetDataModel? data;
  GetFavoriteModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=json['data'] !=null ? GetDataModel.fromJson(json['data']): null;
  }

}
class GetDataModel{
  int ? current_page;
  List<DataModel> data=[];
  GetDataModel.fromJson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  int? id;
  Product? product;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=json['product'] !=null? Product.fromJson(json['product']):null;
  }
}
class Product{
int? id;
dynamic price;
dynamic oldprice;
dynamic discount;
String? image;
String? name;
String? description;
Product.fromJson(Map<String,dynamic>json){
  id=json['id'];
  price=json['price'];
  oldprice=json['old_price'];
  discount=json['discount'];
  name=json['name'];
  image=json['image'];
  description=json['description'];


}
}