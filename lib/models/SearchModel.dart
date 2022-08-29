class SearchModel{
  bool? status;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=json['data'] !=null ? SearchDataModel.fromJson(json['data']): null;
  }

}
class SearchDataModel{
  int ? current_page;
  List<Product> data=[];
  SearchDataModel.fromJson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(Product.fromJson(element));
    });
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
  bool? infav;
  bool? incart;

  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldprice=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    image=json['image'];
    description=json['description'];
    infav=json['in_favorites'];
    incart=json['in_cart'];


  }
}