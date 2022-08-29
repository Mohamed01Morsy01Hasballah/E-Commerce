import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/States.dart';
import 'package:e_commerce/models/GetFavoriteModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/component.dart';

class FavoriteScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
              body: ConditionalBuilder(
                  condition: state is! GetFavoriteLoadingState && cubit.getFavorite !=null,
                  builder: (context)=>ListView.separated(
                      itemBuilder: (context,index)=>GridViewItem(cubit.getFavorite!.data!.data[index].product, context),
                      separatorBuilder: (context,index)=>Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width:double.infinity,
                          height: 2,
                          color: Colors.grey[300],
                        ),
                      ),
                      itemCount: cubit.getFavorite!.data!.data.length
                  ),
                  fallback: (context)=>Center(child: CircularProgressIndicator()
        )
        )
            );
      },
      
    );
  }

}
