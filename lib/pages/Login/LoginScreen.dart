import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/ShopLayout.dart';
import 'package:e_commerce/pages/HomeScreen.dart';
import 'package:e_commerce/pages/Login/LoginCubit.dart';
import 'package:e_commerce/pages/Register/RegisterScreen.dart';
import 'package:e_commerce/shared/Network/local/CacheHelper.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:e_commerce/shared/endPoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LoginState.dart';

class LoginScreen extends StatelessWidget{
  var email=TextEditingController();
  var pass=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<LoginCubit,LoginStates>(
     listener: (context,state){
       var cubit=ShopCubit.get(context);
       if(state is LoginSucessState){
         var c=ShopCubit.get(context);
         if(state.model.status){
           CacheHelper.SaveData(key: 'token', value: state.model.data?.token).then((value) {
             token=state.model.data!.token;
             cubit.GetUserModel();
             cubit.GetFavorite();
             cubit.GetCategory();
             cubit.GetHomeData();
             cubit.GetCarts();
             cubit.GetAddress();
             cubit.GetOrders();
             cubit.currentIndex=0;
             navigateFininsh(context: context,Widget: ShopLayout());
                        });

         }
         else{
           ShowToast(text: state.model.message.toString(), state: ToastState.Error);


         }
       }


       },

     builder:(context,state){

       var cubit =LoginCubit.get(context);
       return Scaffold(
           appBar: AppBar(),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                   key: formkey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Login',
                         style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.black
                         ),
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       BuiltTextField(
                         type: TextInputType.text,
                           controller: email,
                           label: 'Email Address',
                           prefix: Icons.email,
                           validate: (String? value){
                             if(value!.isEmpty){
                               return 'Please Enter Email Address';
                             }
                             return null;

                           }
                       ),
                       SizedBox(
                         height: 20,
                       ),

                       BuiltTextField(
                         type: TextInputType.visiblePassword,
                         controller: pass,
                         secure: cubit.secure,
                           label: 'password',
                           prefix: Icons.lock,
                           suffix: cubit.secure?Icons.visibility_off:Icons.visibility,
                           suffixPressed: (){
                           cubit.changeIcon();
                           },
                           validate: (String? value){
                             if(value!.isEmpty){
                               return 'Please Enter Email Address';
                             }
                             return null;

                           }
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       ConditionalBuilder(
                           condition: state is! LoginLoadingState,
                           builder: (context)=> BuiltButton(
                               height: 50,
                               color: Colors.deepOrange,
                               text: 'Sign',
                               function: (){

                               if(formkey.currentState!.validate()){
                                 cubit.LoginData(email: email.text, password: pass.text);

                               }

                               }
                           ),

                           fallback:(context)=>Center(child: CircularProgressIndicator())
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'dont\'t have Acount ',
                             style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.grey
                             ),

                           ),
                           SizedBox(
                             width: 10,
                           ),
                           TextButton(
                               onPressed: (){
                                 navigatePush(context: context,widget: RegisterScreen());
                               },
                               child: Text(
                                 'Register ',
                                 style: TextStyle
                                   (
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.deepOrangeAccent
                                 ),
                               ))
                         ],
                       )

                     ],
                   ),
                 ),
               ),
             ),
           )
       );
     } ,

   );
  }

}