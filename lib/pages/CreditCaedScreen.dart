import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/ShopLayout.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';

import '../layout/States.dart';

class CreditCardScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();
  var cardNumberController=TextEditingController().text;
  var cardHolderNameController=TextEditingController().text;
  var expiryDateController=TextEditingController().text;
  var cvvCodeController=TextEditingController().text;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){
            if(state is ShopAddOrderSuccessState && ShopCubit.get(context).isCheckedOnline){
              showDialog(
                  context: context,
                  builder: (context)=>Text('payment Success'),
              );
              ShopCubit.get(context).isCheckedOnline=false;

            }
          },
          builder: (context,state){
            return  Scaffold(
                appBar: AppBar(
                  title:Text('Credit Card'),
                 centerTitle: true,
                 leading:IconButton(onPressed: (){
                   navigateFininsh(
                       context: context,Widget: ShopLayout()
                   );
                 }, icon: Icon(
                     Icons.arrow_forward_ios
                 )
                 )

                ),
                body: SingleChildScrollView(

                  child: Column(
                    children: [
                      if(state is ShopAddOrderLoadingState)
                        LinearProgressIndicator(),
                      if(state is ShopAddOrderLoadingState)
                        SizedBox(
                          height: 20,
                        ),

                        CreditCardWidget(
                          glassmorphismConfig: Glassmorphism(
                              blurX: 10.0,
                              blurY: 10.0,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Colors.grey,
                                    Colors.blue.shade300
                                  ],
                                stops: <double>[
                                  0.3,
                                  0
                                ],
                              ),
                          ),
                          onCreditCardWidgetChange: (CreditCardBrand data){},
                          cardNumber: '',
                          expiryDate: '',
                          cardHolderName: '',
                          cvvCode: '',
                          showBackView: true,
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        cardNumber: cardNumberController,
                          expiryDate: expiryDateController,
                          cardHolderName: cardHolderNameController,
                          cvvCode: cvvCodeController,
                          onCreditCardModelChange: (CreditCardModel data){},
                          themeColor: Colors.red,
                          obscureCvv: true,
                          obscureNumber: true,
                          isHolderNameVisible: true,
                          isExpiryDateVisible: true,
                          isCardNumberVisible: true,
                          cardNumberDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Expited Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Card Holder',
                          ),


                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: BuiltButton(
                            height: 50,
                            color: Colors.deepOrange,
                            text: 'validate',
                            function: (){
                              if(formKey.currentState!.validate()){
                                ShopCubit.get(context).addOrder(
                                    addressId: ShopCubit.get(context).addressModel!.data!.details.last.id!,
                                    paymentMethod: 2
                                );
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                )
            );
          },

        );
      },
    );
  }

}