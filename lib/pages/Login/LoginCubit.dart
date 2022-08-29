import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/LoginModel.dart';
import 'package:e_commerce/pages/Login/LoginState.dart';
import 'package:e_commerce/shared/Network/Remote/DioHelper.dart';
import 'package:e_commerce/shared/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(initialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool secure=true;
  void changeIcon(){
    secure=!secure;
    emit(changeIconState());
  }
  LoginModel? login;
  void LoginData(
  {

   required String email,
    required String password
}
      ){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,

        data:
        {
          'email':email,

          'password':password

        }
    ).then((value) {

   login=LoginModel.formJson(value.data);
   print(login!.message);
   emit(LoginSucessState(login!));
    }).catchError((error){
          print('error ${error.toString()}');
          emit(LoginErrorState());
    });
  }
}


