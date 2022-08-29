import 'package:e_commerce/models/LoginModel.dart';

abstract class RegisterStates{}
class RegisterinitialState extends RegisterStates{}
class RegisterchangeIconState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSucessState extends RegisterStates{
  final LoginModel model;
  RegisterSucessState(this.model);
}
class RegisterErrorState extends RegisterStates{}