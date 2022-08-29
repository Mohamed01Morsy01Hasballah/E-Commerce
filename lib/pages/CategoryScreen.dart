import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/States.dart';
import 'package:e_commerce/models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return   Scaffold(
           body:
            ConditionalBuilder(
                condition: cubit.Cmodel !=null,
                builder: (context)=>ListView.separated(
                  physics:  BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>BuiltItem(cubit.Cmodel!.data.data[index]),
                    separatorBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10
                      ),
                      child: Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    itemCount: cubit.Cmodel!.data.data.length
                )
                , fallback: (context)=>Center(
              child:CircularProgressIndicator()
            ))
        );
      },
     
        
        
    );
    
  }
  

}
Widget BuiltItem(dataModel model)=>Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Image(
      image:NetworkImage('${model.image}'),
      fit: BoxFit.cover,
      width:110,
      height: 110,
    ),
    SizedBox(
      width: 10,
    ),
    Text(
      '${model.name}'
    ),
    Spacer(),
    IconButton(
        onPressed: (){},
      icon:Icon(
        Icons.arrow_forward_ios
      )
    )
  ],
);