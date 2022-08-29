class AddressModel{
  bool? status;
  String? message;
  Data? data;
  AddressModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null?Data.fromJson(json['data']):null;

  }
}
class Data{
  int ? currentpage;
   List<Address> details=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perpage;
  String? prevPageUrl;
  int? to;
  int? total;
  Data.fromJson(Map<String,dynamic>json){
    currentpage=json['current_page'];
      json['data'].forEach((element)
      {
        details.add(Address.fromJson(element));
      }
      );
      firstPageUrl=json['first_page_url'];
      from=json['from'];
      lastPage=json['last_page'];
      lastPageUrl=json['last_page_url'];
      nextPageUrl=json['next_page_url'];
      path=json['path'];
      perpage=json['per_page'];
      prevPageUrl=json['prev_page_url'];
      to=json['to'];
      total=json['total'];
    }

}
class Address{
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double? longitude;
  Address.fromJson(Map<String,dynamic>json){
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