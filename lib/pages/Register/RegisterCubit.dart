import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/LoginModel.dart';
import 'package:e_commerce/pages/Login/LoginState.dart';
import 'package:e_commerce/shared/Network/Remote/DioHelper.dart';
import 'package:e_commerce/shared/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterinitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  bool secure=true;
  void changeIcon(){
    secure=!secure;
    emit(RegisterchangeIconState());
  }
  LoginModel? login;
  void RegisterData(
      {
        required String name,
        required String email,
        required String password,
        required String phone

      }
      ){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,

        data:
        {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone

        }
    ).then((value) {

      login=LoginModel.formJson(value.data);
      print(login!.message);
      emit(RegisterSucessState(login!));
    }).catchError((error){
      print('error ${error.toString()}');
      emit(RegisterErrorState());
    });
  }
}


