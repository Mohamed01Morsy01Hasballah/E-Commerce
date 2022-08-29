
import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/ShopLayout.dart';
import 'package:e_commerce/pages/Login/LoginCubit.dart';
import 'package:e_commerce/pages/Login/LoginScreen.dart';
import 'package:e_commerce/pages/Login/LoginState.dart';
import 'package:e_commerce/pages/Register/RegisterCubit.dart';
import 'package:e_commerce/pages/Search/cubit.dart';
import 'package:e_commerce/pages/onBoarding.dart';
import 'package:e_commerce/shared/Network/local/CacheHelper.dart';
import 'package:e_commerce/shared/Network/Remote/DioHelper.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:e_commerce/shared/endPoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

      DioHelper.init();
      await CacheHelper.getinit();
     bool? onboard= CacheHelper.getBooleanData(key: 'onBoarding');
      token= CacheHelper.getStringData(key: 'token');
      print(token);

     Widget widget;
     if(onboard !=null ){
       if(token !=null)
       {
         widget=ShopLayout();
       }
       else
       {
         widget=LoginScreen();
       }

     }else{
       widget=OnBoarding();
     }
      runApp(E_Commerce(widget: widget,));

}
class E_Commerce extends StatelessWidget{
  final Widget? widget;
  E_Commerce({this.widget});
  @override
  Widget build(BuildContext context)
  {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>LoginCubit(),
        ),

        BlocProvider(
          create: (context)=>RegisterCubit(),
        ),
        BlocProvider(
          create: (context)=>SearchCubit(),
        ),
        BlocProvider(
          create: (context)=>ShopCubit()..GetHomeData()..GetCategory()..GetFavorite()..GetUserModel()..GetCarts()..GetAddress()..GetOrders(),
        ),
      ],
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){},
        builder: (context,state){
          return MaterialApp (
            debugShowCheckedModeBanner: false,

              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                    ),

                    iconTheme:IconThemeData(
                        color: Colors.black
                    ) ,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarBrightness: Brightness.light
                    )
                ),

              ),
            home: widget,
          );
        },

      ),
    );
  }

}