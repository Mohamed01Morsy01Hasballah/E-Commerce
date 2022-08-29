import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/pages/order/OrderScreen.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/Cubit.dart';
import '../../layout/States.dart';
import '../../models/GetCarts.dart';

class CartsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        const vatNumber=7.1428571429;
       return Scaffold(
         appBar: AppBar(
         title:  Text(
             'Carts',
           )
         ),
          body: ConditionalBuilder(
              condition: state is! ShopCartAddAndDeleteLoadingState,
              builder: (context)=>Padding(
       padding: const EdgeInsets.all(20.0),
        child: Column(
        children: [
        Row(
        children: [
        Text(
        'Subtotal',
        style:TextStyle(
        fontSize:20,
        fontWeight:FontWeight.bold
        )
        ),
        Spacer(),
        Text(
        'EGP',
        style:TextStyle(
        fontSize:20,
        fontWeight:FontWeight.bold
        )

        ),
        Text(
        '${cubit.getCart!.data!.subTotal}',
        style:TextStyle(
        fontSize:20,
        fontWeight:FontWeight.bold,
        color: Colors.deepOrange
        )

        ),
        ],
        ),
        SizedBox(height: 5,),
        if(state is ShopUpdateCartLoadingState)
        SizedBox(height:5),
        if(state is ShopUpdateCartLoadingState)
        LinearProgressIndicator(),
        if(state is ShopUpdateCartLoadingState)
        SizedBox(height: 5,),

        Expanded(
        child: ListView.separated (
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>BuiltItemList(cubit.getCart!.data!.cartItems![index],context),
        separatorBuilder: (context,index)=>myDivider(),
        itemCount: cubit.getCart!.data!.cartItems!.length
        ),
        ),
        BuiltButton(
        height: 50,
        color: Colors.deepOrange,
        text: 'Checkout',
        function: (){
        dynamic vat =cubit.getCart!.data!.subTotal !/vatNumber;
        dynamic total =cubit.getCart!.data!.subTotal +vat;
        navigatePush(
        context:context,
        widget: OrderScreen(
          getmodel:cubit.getCart,
          vat:vat,
          total:total,
          change: cubit.changeCart,
        )
        );
        }
        )





        ],
        ),
        ),
              fallback:(context) =>Center(child: CircularProgressIndicator())
          )
        );
      },
    );
  }

}
Widget BuiltItemList(CartItems model,context)=>Container(
  height: 120,
  color: Colors.white,
  child:   Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
              image: NetworkImage('${model.product!.image}'),
            height: 110,
            width: 110,
            fit: BoxFit.fill,
          ),
          if(model.product!.discount !=0)

          Container(
            color: Colors.deepOrangeAccent,

            height: 20,

            width: 60,

            child: Text(
                'Discount',
            textAlign: TextAlign.center,
              style: TextStyle(
                color:Colors.white
              ),
            ),

          )
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(

              '${model.product!.name}',

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(

                  fontSize: 13

              ),

            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${model.product!.price}'
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${model.product!.oldPrice}',
                  style: TextStyle

                    (

                      fontSize: 15,

                      color:  Colors.grey,

                      decoration:TextDecoration.lineThrough

                  ),
                )
              ],
            ),
            Row(
                         children: [
                           Container(
                             height:28,
                             width: 30,
                             decoration: BoxDecoration(

                               borderRadius: BorderRadius.circular(8.0),
                               color: Colors.deepOrange
                             ),
                             child: IconButton(
                                 onPressed: (){

                                     ShopCubit.get(context).updateCart(
                                         model.id!,
                                       --model.quantity
                                     );

                                   if(model.quantity ==0){
                                     ShopCubit.get(context).AddAndRemoveCart(model.product!.id!);
                                   }
                                 },
                                 icon: Icon(
                                   Icons.remove,
                                   color: Colors.white,
                                   size:14
                                 )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal:10 ),
                              child: Text(
                               '${model.quantity}'
                             ),
                          ),
                          Container(
                             height:28,
                             width: 30,
                             decoration: BoxDecoration(

                                 borderRadius: BorderRadius.circular(8.0),
                                 color: Colors.deepOrange
                            ),
                             child: IconButton(
                                 onPressed: (){
                                   ShopCubit.get(context).updateCart(
                                       model.id!,
                                       ++model.quantity
                                   );
                                 },
                                 icon: Icon(
                                     Icons.add,
                                     color: Colors.white,
                                     size:14
                                 )
                             ),
                           ),
                           Spacer(),
                           IconButton(
                              onPressed: (){
                                ShopCubit.get(context).AddAndRemoveCart(model.product!.id!);
                               },
                               icon: Icon(
                                 Icons.remove_shopping_cart_sharp,
                                 color:Colors.deepOrange,
                                 size: 30,
                               )
                           )
                         ],
                      )

          ],
        ),
      )


    ],
  ),
);