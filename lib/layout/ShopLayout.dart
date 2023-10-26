import 'package:e_commerce/layout/Cubit.dart';
import 'package:e_commerce/layout/States.dart';
import 'package:e_commerce/pages/CreditCaedScreen.dart';
import 'package:e_commerce/pages/Search/SearchScreen.dart';
import 'package:e_commerce/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/Address/AddAddress.dart';
import '../pages/Address/UpdateAdressScreen.dart';
import '../pages/Carts/CartsScreen.dart';
import '../pages/Question/QuestionScreen.dart';

class ShopLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigatePush(context:context,widget: SearchScreen());
                  },
                  icon: Icon(Icons.search)
              )
            ],
          ),
          drawer: Drawer(

            child: ListView(
              padding: EdgeInsets.zero,
              children: [
             if(cubit.userData !=null)
               UserAccountsDrawerHeader(
                 decoration: BoxDecoration(
                   color:Colors.black54
                 ),
                   accountName: Text(
                     '${cubit.userData!.data!.name}',
                     style: TextStyle(
                       color: Colors.white
                     ),
                   ),
                   accountEmail: Text(
                     '${cubit.userData!.data!.email}',
                     style: TextStyle(
                         color: Colors.white
                     ),
                   )
               ),
                ListTile(
                  title: Text('Carts'),
                  leading: Icon(
                    Icons.shopping_cart_outlined
                  ),
                  onTap: (){
                    navigatePush(context:context,widget: CartsScreen());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person_outline_outlined
                  ),
                  title: Text(' Update Address'),
                  onTap: (){
                    navigatePush(context:context,widget: UpdateAddressScreen());
                  },
                ),
                myDivider(),
                ListTile(
                  leading: Icon(
                      Icons.question_answer_outlined
                  ),
                  title: Text('credit card'),
                  onTap: (){
                    navigatePush(context:context,widget: CreditCardScreen());
                  },
                ),



              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type:BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home
                  ),
                  label: ' Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.apps
                  ),
                  label: ' category'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite
                  ),
                  label: ' Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings
                  ),
                  label: ' Settings'
              ),

            ],
          ),
          body:cubit.Screen[cubit.currentIndex] ,
        );
      },

    );
  }

}