class GetCartsModel{
  bool? status;
  String? message;
  Data? data;
  GetCartsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null ?Data.fromJson(json['data']): null;
  }
}
class Data{
  List<CartItems>? cartItems;
  dynamic subTotal;
  dynamic total;
  Data.fromJson(Map<String,dynamic>json){
    if(json['cart_items'] !=null){
      cartItems=<CartItems>[];
      json['cart_items'].forEach((element){
        cartItems!.add(CartItems.fromJson(element));
      });
    }
    subTotal=json['sub_total'];
    total=json['total'];
  }
}
class CartItems{

  int? id;
  late int quantity;
  Product? product;
  CartItems.fromJson(Map<String,dynamic>json){
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
  bool? infavorite;
  bool? incart;
  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    image=json['image'];
    description=json['description'];
    infavorite=json['in_favorites'];
    incart=json['in_cart'];
  }
}