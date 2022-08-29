class AddAdressModel{
  bool? status;
  String? message;
  Data? data;
  AddAdressModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null?Data.fromJson(json['data']):null;
  }
}
class Data{
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double? longitude;
  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    city=json['city'];
    region=json['region'];
    details=json['details'];
    notes=json['notes'];
    latitude=json['latitude'];
    longitude=json['longitude'];
  }
}