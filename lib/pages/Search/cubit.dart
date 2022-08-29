import 'package:bloc/bloc.dart';
import 'package:e_commerce/pages/Search/States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/SearchModel.dart';
import '../../shared/Network/Remote/DioHelper.dart';
import '../../shared/component.dart';
import '../../shared/endPoints.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? Smodel;
  void GetSearch({
    required String text
  }){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text
        },
        token: token
    ).then((value) {
      Smodel=SearchModel.fromJson(value.data);
      emit(ShopSearchSucessState());
    }).catchError((error){
      print('error ${error.toString()}');
      emit(ShopSearchErrorState());
    });
  }
}