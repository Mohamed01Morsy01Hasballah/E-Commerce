
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/Cubit.dart';
import '../../layout/States.dart';
import '../../shared/component.dart';

class UpdateAddressScreen extends StatelessWidget{
  var region=TextEditingController();
  var details=TextEditingController();
  var cityname=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context).addressModel!.data!.details.last;
          cityname.text = cubit.city!;
          region.text = cubit.region!;
          details.text = cubit.details!;


        return  Scaffold(
          appBar:AppBar(
            title: Text(
                'Update Address '
            ),
          ),
          body:BuiltItemAddress(state, context),



    );

  }
    );
  }

  Widget BuiltItemAddress(ShopStates state ,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if(state is ShopUpdateAddressLoadingState)
              SizedBox(
                height: 5,
              ),
            if(state is ShopUpdateAddressLoadingState)
              LinearProgressIndicator(),
            if(state is ShopUpdateAddressLoadingState)
              SizedBox(
                height: 10,
              ),
            BuiltTextField(
                label: 'City Name',
                type: TextInputType.name,
                controller:cityname ,
                prefix: Icons.location_city,
                validate: (String? value){
                  if(value!.isEmpty){
                    return "please Enter Region";
                  }
                  return null;
                }
            ),

            SizedBox(
              height: 20,
            ),

              BuiltTextField(
                label: 'Region Address',
                type: TextInputType.streetAddress,
                controller:region ,
                prefix: Icons.location_city_outlined,
                validate: (String? value){
                  if(value!.isEmpty){
                    return "please Enter Region";
                  }
                  return null;
                }
            ),
            SizedBox(
              height: 20,
            ),

              BuiltTextField(
                label: 'Street Address',
                type: TextInputType.streetAddress,
                controller:details ,
                prefix: Icons.streetview_outlined,
                validate: (String? value){
                  if(value!.isEmpty){
                    return "please Enter Street Address";
                  }
                  return null;
                }
            ),
            SizedBox(
              height: 20,
            ),
            BuiltButton(
                height: 50,
                color: Colors.deepOrange,
                text: 'Update',
                function: (){
                  if(formKey.currentState!.validate()){
                    ShopCubit.get(context).UpdateAddress(
                        addressId: ShopCubit.get(context).addressModel!.data!.details.last.id!,
                        city: cityname.text,
                        name:ShopCubit.get(context).userData!.data!.name! ,
                        region: region.text,
                        details: details.text
                    );
                  }
                }
            )

          ],
        ),
      ),
    ),
  );
}