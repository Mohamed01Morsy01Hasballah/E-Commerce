import 'package:e_commerce/models/SearchModel.dart';
import 'package:e_commerce/pages/Search/States.dart';
import 'package:e_commerce/pages/Search/cubit.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/Cubit.dart';

class SearchScreen extends StatelessWidget{
  var text=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SearchCubit,SearchStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SearchCubit.get(context);
        return  Scaffold(
          appBar: AppBar(),
          body:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    BuiltTextField(
                        label: 'Search',
                        type: TextInputType.text,
                        controller: text,
                        prefix: Icons.search,
                      validate: (String? value){
                          if(value!.isEmpty){
                            return 'Please Enter Search';
                          }
                          return null;
                      },
                      onsubmit: (String text){
                            SearchCubit.get(context).GetSearch(text: text);

                      }

                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>GridViewItem(cubit.Smodel!.data!.data[index], context),
                          separatorBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width:double.infinity,
                              height: 2,
                              color: Colors.grey[300],
                            ),
                          ),
                          itemCount: cubit.Smodel!.data!.data.length
                      ),
                    ),



                  ],
                ),
              ),
            )
        );
      },

    );
  }

}
