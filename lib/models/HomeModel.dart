
class HomeModel{
late  bool status;
 late HomeData data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=HomeData.fromjson(json['data']);
  }
}
class HomeData{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  HomeData.fromjson(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
     products.add(ProductModel.fromJson(element));
    });


  }

}
class BannerModel{
late String image;
BannerModel.fromJson(Map<String,dynamic>json){
  image=json['image'];
}
}
class ProductModel{
 late int id;
late String name;
late dynamic price;
late dynamic oldPrice;
 late dynamic discount;
String? image;
late bool inFavorite;
late bool inCart;
ProductModel.fromJson(Map<String,dynamic>json){
  id=json['id'];
  name=json['name'];
  image=json['image'];
  price=json['price'];
  oldPrice=json['old_price'];
  discount=json['discount'];
  inFavorite=json['in_favorites'];
  inCart=json['in_cart'];

}

}