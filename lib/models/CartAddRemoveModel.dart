class CartAddRemove{
  bool? status;
  String? message;
  Data? data;
  CartAddRemove.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data =json['data'] != null ?Data.fromJson(json['data']) : null;

  }
}
class Data{
  int? id;
  int? quantity;
  Product? product;
  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    quantity=json['quantity'];
    product=json['product'] !=null ?Product.fromJson(json['product']):null;
  }
}
class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    image=json['image'];
    description=json['description'];
  }
}