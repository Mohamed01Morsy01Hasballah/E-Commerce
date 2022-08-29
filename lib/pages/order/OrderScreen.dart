import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/models/GetCarts.dart';
import 'package:e_commerce/pages/CreditCaedScreen.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/States.dart';
import '../../models/CartAddRemoveModel.dart';

class OrderScreen extends StatelessWidget{
  GetCartsModel? getmodel;
  CartAddRemove? change;
  dynamic vat;
  dynamic total;
  OrderScreen({this.getmodel,this.vat,this.total,this.change});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopAddOrderSuccessState && ShopCubit.get(context).isCeckedCach){
          getmodel!.data!.subTotal=0;
        vat=0;
          total=0;
          showDialog(
        context: context,
        builder: (context)=>Text(
          'Payment Success'
        )
        );
        }
        if(ShopCubit.get(context).isCheckedOnline){
          navigatePush(
          context: context,
          widget: CreditCardScreen()
          );
        }
      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Order'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(state is ShopAddOrderLoadingState)
                LinearProgressIndicator(),
              Card(
                elevation: 30,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.deepOrange,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:Colors.grey[400]
                      ),
                      child: Row(
                        children: [
                          Text(
                              'Address Details ',
                          style: TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.5
                          ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: (){
                                print(cubit.isValidate);
                              },
                              child: Text(
                                'change',
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height:10
                    ),
                    Text(
                      cubit.addressModel!.data!.details.last.city!,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cubit.addressModel!.data!.details.last.details!,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cubit.userData!.data!.phone!,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   Row(
                     children: [
                       Checkbox(
                           value: cubit.isCeckedCach,
                           onChanged: (value){
                             cubit.num=1;
                             cubit.changeCheckedOrder(value);
                             cubit.isCheckedOnline=false;
                           }
                       ),
                       SizedBox(
                         width: 5,
                       ),
                       Text(
                         'Cash',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                         ),
                       )
                     ],
                   ),
                    myDivider(),
                    Row(
                      children: [
                        Checkbox(
                            value: cubit.isCheckedOnline,
                            onChanged: (value){
                              cubit.num=2;
                              cubit.changeCheckedOrder(value);
                              cubit.isCeckedCach=false;
                            }
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'online',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('SubTotal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        Spacer(),
                        Text(
                            '${getmodel!.data!.subTotal!}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        Text('Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        Spacer(),
                        Text(
                          '${total}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        Text('Vat',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                        Spacer(),
                        Text(
                          '${vat}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BuiltButton(
                        height: 50,
                        color: Colors.deepOrange,
                        text: 'payment',
                        function: (){
                          if(cubit.isCeckedCach && getmodel!.data!.subTotal !=0){
                            cubit.addOrder(
                                addressId: cubit.addressModel!.data!.details.last.id!,
                                paymentMethod: cubit.num
                            );
                          }else{
                            ShowToast(text: 'payment method must be selected', state:ToastState.Error);
                          }

                        }
                    )


                  ],
                )
              ),
            ],
          ),
        );
      },

    );
  }

}