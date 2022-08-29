import 'package:bloc/bloc.dart';
import 'package:e_commerce/layout/ShopLayout.dart';
import 'package:e_commerce/layout/States.dart';
import 'package:e_commerce/models/AddAddressModel.dart';
import 'package:e_commerce/models/AddressModel.dart';
import 'package:e_commerce/models/CartAddRemoveModel.dart';
import 'package:e_commerce/models/CategoryModel.dart';
import 'package:e_commerce/models/FavoriteModel.dart';
import 'package:e_commerce/models/GetCarts.dart';
import 'package:e_commerce/models/GetOrderModel.dart';
import 'package:e_commerce/models/HomeModel.dart';
import 'package:e_commerce/models/SearchModel.dart';
import 'package:e_commerce/pages/CategoryScreen.dart';
import 'package:e_commerce/pages/FavoriteScreen.dart';
import 'package:e_commerce/pages/HomeScreen.dart';
import 'package:e_commerce/pages/Login/LoginScreen.dart';
import 'package:e_commerce/pages/SettingScreen.dart';
import 'package:e_commerce/shared/Network/local/CacheHelper.dart';
import 'package:e_commerce/shared/endPoints.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/GetFavoriteModel.dart';
import '../models/LoginModel.dart';
import '../shared/Network/Remote/DioHelper.dart';
import '../shared/component.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(initialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  void ChangeNavBar(int index){
    currentIndex=index;
    emit(ChangeNavBarState());

  }
  List<Widget> Screen=[
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];

  void signout(context){
    emit(ShopSignOutLoadingState());
    DioHelper.postData(
        url: 'logout',
        data: {

        },
        token: token,
    ).then((value) {
      token=' ';
      CacheHelper.RemoveData(key: 'token').then((value) {
        navigateFininsh(context: context,Widget: LoginScreen());
      });
      emit(ShopSignOutSuccessState());

    }).catchError((error){
      print('error ${error.toString()}');
      emit(ShopSignOutErrorState());


    });
  }
  HomeModel? home;
  Map<int,bool> favortie={};
  Map<int,bool> cart={};


  void GetHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(
        url: HOME,
        token:token ,
    ).then((value) {
      home=HomeModel.fromJson(value.data);
        home!.data.products.forEach((element) {
            favortie.addAll({
              element.id:
              element.inFavorite
            });
        });
      home!.data.products.forEach((element) {
        cart.addAll({
          element.id:
              element.inCart
        });
      });
        print(favortie.toString());
      // print(home!.data!.banners[0].image);
      emit(HomeSuccessState());
    }).catchError((error){
      print('error${error.toString()}');
      emit(HomeErrorState());
    });
  }
  CategoryModel? Cmodel;
  void GetCategory(){
    emit(CategoryLoadingState());

    DioHelper.getData(
        url:CATEGORY,
     // token: token
    ).then((value) {
      Cmodel=CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
      print(Cmodel!.data);
      print('fggh');
      print(Cmodel!.status);

    }).catchError((error){
      print('error ${error.toString()}');
      emit(CategoryErrorState());
    });
  }
  FavoriteModel ? Fmodel;
  void Favorite(int productId){
    favortie[productId] = !favortie[productId]!;
    emit(FavoriteLoadingState());
    DioHelper.postData(
        url: FAVORITE,
        token: token,
        data: {
          'product_id':productId
        }
    ).then((value) {
      emit(FavoriteSuccessState());

      Fmodel=FavoriteModel.fromJson(value.data);
      if(Fmodel!.status==false){
        favortie[productId] = !favortie[productId]!;

      }else{
        GetFavorite();
      }
      print(value.data);
    }).catchError((error){
      favortie[productId] = !favortie[productId]!;

      print('error ${error.toString()}');
      emit(FavoriteErrorState());


    });
  }
  GetFavoriteModel? getFavorite;
  void GetFavorite(){
    emit(GetFavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITE,
      token:token,
    ).then((value){
      getFavorite=GetFavoriteModel.fromJson(value.data);
      emit(GetFavoriteSuccessState());
    })
        .catchError((error){
          print('error ${error.toString()}');
          emit(GetFavoriteErrorState());
    });
  }
  LoginModel? userData;
  void GetUserModel(){
    emit(ShopUserDataLoadingState());
    DioHelper.getData(
        url: PROFILE,
      token: token,
    ).then((value){
         userData=LoginModel.formJson(value.data);
         emit(ShopUserDataSucessState());
    }).catchError((error)
    {
      emit(ShopUserDataErrorState());
     print('error ${error.toString()}');
    });
  }
  void GetUpdateUser({
    required String name,
    required String email,
    required String phone,

  }){
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.PutData(
      url: UPDATE_PROFILE,

      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone
      },

    ).then((value){
      userData=LoginModel.formJson(value.data);
      emit(ShopUpdateUserDataSucessState());
    }).catchError((error)
    {
      emit(ShopUpdateUserDataErrorState());
      print('error ${error.toString()}');
    });
  }
  int counter=0;
  void ChangeCart(id){
    cart[id] = !cart[id]!;
    if(cart[id]!){
      counter++;
    }
    else{
      counter--;
    }

emit(ShopChangeCartState());
  }

CartAddRemove? changeCart;
  void AddAndRemoveCart(int productId){
    emit(ShopCartAddAndDeleteLoadingState());
    ChangeCart(productId);
    DioHelper.postData(
        url: CARTS,
        data: {
          'product_id':productId
        },
      token: token,
    ).then((value) {
      emit(ShopCartAddAndDeleteSucessState());

      changeCart=CartAddRemove.fromJson(value.data);
      if(changeCart!.status ==false){
        ChangeCart(productId);

      }else{
        GetCarts();
      }

      print(value.data);

    }).catchError((error){
      ChangeCart(productId);

      print('error ${error.toString()}');
      emit(ShopCartAddAndDeleteErrorState());

    });

  }
  GetCartsModel? getCart;
  void GetCarts(){
    emit(ShopGetCartLoadingState());
    DioHelper.getData(
        url: 'carts',
      token: token,
    ).then((value) {
      getCart = GetCartsModel.fromJson(value.data);
      emit(ShopGetCartSucessState());

    }).catchError((error){
      print('error ${error.toString()}');
      emit(ShopGetCartErrorState());

    });
  }
  void updateCart(int productId,int quantity){
    emit(ShopUpdateCartLoadingState());
    DioHelper.PutData(
        url: 'carts/$productId',
        data: {
          'quantity':quantity
        },
      token:token
    ).then((value) {
      emit(ShopUpdateCartSuccessState());
      GetCarts();
    })
        .catchError((error){
      emit(ShopUpdateCartErrorState());
    });

  }
  AddAdressModel ? addModel;
  void addAddress({
  required String city,
    required String name,
    required  String region,
    required String details
}){
    emit(ShopAddAddressLoadingState());
    DioHelper.postData(
        url: 'addresses',
        data: {
          'name':name,
          'city':city,
          'region':region,
          'details':details,
          'latitude':30.061686,
          'longitude':31.3260088,
          'notes':"work address"
        },
      token: token
    ).then((value) {
      emit(ShopAddAddressSuccessState());
      GetAddress();
     // addModel=AddAdressModel.fromJson(value.data);
    }).catchError((error){
      print('error ${error.toString()}');
      emit(ShopAddAddressErrorState());
    });
  }
  AddressModel? addressModel;
  void GetAddress(){
    emit(ShopGetAddressLoadingState());
    DioHelper.getData(
        url: 'addresses',
      token: token,
    ).then((value) {
      addressModel=AddressModel.fromJson(value.data);
      emit(ShopGetAddressSuccessState());
    }).catchError((error){
      print('srror ${error.toString()}');
      emit(ShopGetAddressErrorState());

    });
  }
 void UpdateAddress(
     {
    required int addressId,
    required String city,
    required String name,
    required  String region,
    required String details
}
     ){
    emit(ShopUpdateAddressLoadingState());
    DioHelper.PutData(
        url: 'addresses/$addressId',
        data: {
          'name':name,
          'city':city,
          'region':region,
          'details':details,
          'latitude':30.061686,
          'longitude':31.3260088,
          'notes':"work address"
        },
      token: token
    ).then((value) {
      emit(ShopUpdateAddressSuccessState());
      GetAddress();
     addressModel=AddressModel.fromJson(value.data);
    }).catchError((error){
      emit(ShopUpdateAddressErrorState());
    });
 }
  bool isCeckedCach=false;
  bool isCheckedOnline=false;
  int num=0;
  void changeCheckedOrder(var value){
    if(num == 1){
      isCeckedCach= !isCeckedCach;
      emit(ShopCheckCachState());
    }
    if(num == 2){
      isCheckedOnline= !isCheckedOnline;
      emit(ShopCheckCachState());

    }
  }
  bool isValidate=false;
  void validateCreditCard(bool value){
    if(value){
      isValidate=true;
      emit(ShopCheckCreditCartState());
    }
  }
  void addOrder({
  required int addressId,
    required int paymentMethod,
}){
    emit(ShopAddOrderLoadingState());
    DioHelper.postData(
        url: 'orders',
        data: {
          'address_id':addressId,
          'payment_method':paymentMethod,
          'use_points':false
        },
      token: token
    ).then((value) {
      emit(ShopAddOrderSuccessState());
      GetCarts();
    }).catchError((error){
      emit(ShopAddAddressErrorState());
      print('error ${error.toString()}');
    });
  }
  GetOrderModel? getOrderModel;
  void GetOrders(){
    emit(ShopGetOrderLoadingState());
    DioHelper.getData(url: 'orders',
    token: token
    ).then((value) {
      emit(ShopGetOrderSuccessState());
      getOrderModel=GetOrderModel.fromJson(value.data);
    }).catchError((error){
      emit(ShopGetOrderErrorState());
      print('error ${error.toString()}');
    });
  }
}