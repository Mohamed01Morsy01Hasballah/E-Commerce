import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/layout/States.dart';
import 'package:e_commerce/models/CategoryModel.dart';
import 'package:e_commerce/models/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/Cubit.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
      (
        listener: (context,state){},
        builder: (context, state){
          var cubit=ShopCubit.get(context);
         return RefreshIndicator(
           onRefresh: () async{
             return cubit.GetHomeData();
           },
           child: ConditionalBuilder(
                condition: cubit.home !=null && cubit.Cmodel !=null,
                builder: (context)=>BuiltItem(ShopCubit.get(context).home!,cubit.Cmodel!,context),
                fallback:(context)=> Center(child: CircularProgressIndicator())
            ),
         );

        }
    );
  }
  Widget BuiltItem(HomeModel model, CategoryModel cmodel,context)=> SingleChildScrollView(
    physics:BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CarouselSlider(
                items:model.data.banners.map((e) =>
                     Image(
                       image:NetworkImage('${e.image}'),
                       fit:BoxFit.cover,
                       width: double.infinity
                       ,)
                ).toList(),
                 options: CarouselOptions(
                 initialPage: 0,
                  height: 250,
                   autoPlay: true,
                   reverse: false,
                   autoPlayAnimationDuration: Duration(seconds: 1),
                   autoPlayInterval: Duration(seconds: 3),
                   autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                   enableInfiniteScroll: true,
                   viewportFraction: 1.0
                )
           ),
             SizedBox(
               height: 10,
             ),
             Padding(
               padding: const EdgeInsets.symmetric(
                 horizontal: 20
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Category',
                     style: TextStyle(
                       fontSize: 20,
                     ),
                   ),
           Container(
                   height: 120,
                   child: ListView.separated(
                     scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index)=>ListViewItem(cmodel.data.data[index]),
                       separatorBuilder: (context,index)=>SizedBox(width: 10,),
                       itemCount: cmodel.data.data.length
                   ),
           ),
           SizedBox(
                   height: 10,
           ),
           Text(
                   'New Products',
                   style: TextStyle(
                     fontSize: 20,
                   ),
           ),
                 ],
               ),
             ),
           SizedBox(
             height: 30,
           ),



           Container(
               color:Colors.grey[300] ,
               child: GridView.count(
                  shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   crossAxisCount: 2,
                 mainAxisSpacing: 1,
                 crossAxisSpacing: 1,
                 childAspectRatio: 1/1.74,
                 children: List.generate(model.data.products.length, (index) =>
                 GridViewItem(model.data.products[index],context)
                 ),

               ),
           )
         ],
       ),
            );

}
Widget GridViewItem(ProductModel model,context)=>Container(
  color: Colors.white,
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
          Stack(
            alignment:AlignmentDirectional.bottomStart ,
            children: [
              Image(

        image: NetworkImage('${model.image}'),

        fit: BoxFit.fill,
        width: double.infinity,
        height: 200,

      ),
              if(model.discount !=0)
              Container(
                color: Colors.deepOrangeAccent,
                height: 20,
                width: 60,
                child: Text(
                  'Discount',
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  ),

                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
        '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13
                  ),
      ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        color:  Colors.indigo,
                        fontSize: 15
                      ),
                    ),
                    Spacer(),

                    Text(
                      '${model.oldPrice}',

                      style: TextStyle
                        (
                        fontSize: 15,
                          color:  Colors.grey,
                        decoration:TextDecoration.lineThrough
                      ),
                    ),




                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          print(model.id);
                          ShopCubit.get(context).Favorite(model.id.toInt());
                        },

                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: ShopCubit.get(context).favortie[model.id]!  ? Colors.redAccent:Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        )
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          print(model.id);
                          ShopCubit.get(context).AddAndRemoveCart(model.id.toInt());
                        },


                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: ShopCubit.get(context).cart[model.id]!  ? Colors.redAccent:Colors.grey,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          )

    ],
  ),
);
Widget ListViewItem(dataModel? model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children:
  [
    Image(
      image:NetworkImage('${model!.image}'),
      height:110,
      width:110,
          fit: BoxFit.cover,
    ),
    Container(
          width: 110,
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(0.7)
          ),
          child:Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow:TextOverflow.ellipsis,
             style: TextStyle(
               fontSize: 16,
               color: Colors.white
             ),
          ),
        ),
  ],
);
