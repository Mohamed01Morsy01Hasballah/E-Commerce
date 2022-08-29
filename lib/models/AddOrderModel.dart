import 'package:e_commerce/models/CartAddRemoveModel.dart';
import 'package:flutter/material.dart';

class AddOrderModel{
bool? status;
String? message;
Data? data;
AddOrderModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  message=json['message'];
  data=json['data'] !=null?Data.fromJson(json['data']):null;
}

}
class Data{
  String? paymentMethod;
  dynamic cost;
  dynamic vat;
  dynamic discount;
  int? points;
  dynamic total;
  int? id;
  Data.fromJson(Map<String,dynamic>json){
    paymentMethod=json['payment_method'];
    cost=json['cost'];
    vat=json['vat'];
    discount=json['discount'];
    points=json['points'];
    total=json['total'];
    id=json['id'];
  }
}