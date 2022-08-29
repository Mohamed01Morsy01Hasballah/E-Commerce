import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/pages/Address/AddAddress.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/Cubit.dart';
import '../layout/States.dart';

class SettingScreen extends StatelessWidget{
  var name=TextEditingController();
  var email=TextEditingController();
  var phone=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var model=ShopCubit.get(context).userData;
          name.text=model!.data!.name.toString();
          email.text=model.data!.email.toString();
          phone.text=model.data!.phone.toString();
          return ConditionalBuilder(
              condition: state is! ShopUserDataLoadingState && ShopCubit.get(context).userData!=null,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Center(
                    child: Form(
                      key: formKey,

                      child: Column(
                        children: [
                          if(state is ShopUpdateUserDataLoadingState)
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),

                          BuiltTextField(
                            label: 'Name',
                            type: TextInputType.name,
                            controller: name,
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BuiltTextField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: email,
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BuiltTextField(
                            label: 'Phone',
                            type: TextInputType.phone,
                            controller: phone,
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BuiltButton(
                              height: 50,
                              color: Colors.deepOrangeAccent,
                              text: 'update',
                              function:(){
                                if(formKey.currentState!.validate()){
                                  ShopCubit.get(context).GetUpdateUser(
                                      name: name.text,
                                      email: email.text,
                                      phone: phone.text
                                  );
                                }
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          BuiltButton(
                              height: 50,
                              color: Colors.deepOrangeAccent,
                              text: 'Signout',
                              function:(){
                                ShopCubit.get(context).signout(context);
                              }
                          ),
                          if(ShopCubit.get(context).addressModel!.data!.details.isEmpty)
                            SizedBox(
                              height: 20,
                            ),
                          if(ShopCubit.get(context).addressModel!.data!.details.isEmpty)

                            BuiltButton(
                              height: 50,
                              color: Colors.deepOrangeAccent,
                              text: 'Add Address',
                              function:(){
                                navigatePush(context:context,widget: AddAddressScreen());
                              }
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator())
          );
        },
      )
    );
  }

}