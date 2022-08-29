class GetOrderModel{
  bool? status;
  String? message;
  Data? data;
  GetOrderModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null?Data.fromJson(json['data']):null;

  }

}
class Data{
  int ? currentpage;
  List<Details>? details;
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
    if(json['data'] !=null){
      details=<Details>[];
      json['data'].forEach((element){
        details!.add(Details.fromJson(element));
      });
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
}
class Details{
  int? id;
  dynamic total;
  String? date;
  String? status;
  Details.fromJson(Map<String,dynamic>json){
    id=json['id'];
    total=json['total'];
    date=json['date'];
    status=json['status'];

  }

}
