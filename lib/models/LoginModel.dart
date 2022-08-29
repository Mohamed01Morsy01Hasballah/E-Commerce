class LoginModel{
   late bool status;
  String? message;
  UserLogin? data;
  LoginModel.formJson(Map<String,dynamic >json){
    status=json['status'];
    message=json['message'];
    data= json["data"] != null ? UserLogin.formJson(json["data"]) : null;
  }
}
class UserLogin{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;

  int? credits;
  String? token;
  UserLogin.formJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credits=json['credits'];
    token=json['token'];
  }
}