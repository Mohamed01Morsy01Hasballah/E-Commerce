import 'package:e_commerce/models/LoginModel.dart';

abstract class LoginStates{}
class initialState extends LoginStates{}
class changeIconState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{
 final LoginModel model;
  LoginSucessState(this.model);
}
class LoginErrorState extends LoginStates{}