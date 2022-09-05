
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/layout/news_app/cubit/states.dart';
import 'package:news_application/news_app/sports/sports_screen.dart';

import '../../../news_app/business/business_screen.dart';
import '../../../news_app/science/science_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;

  List<BottomNavigationBarItem> bottomItem = const[
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: '  Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget> screens = const[
    SportsScreen(),
    BusinessScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
    url: 'v2/top-headlines',
    query: {
      'country':'eg',
      'category':'business',
      'apiKey':'a568325f53c041ccb362e8c6cf18dcd1',
    },
  ).then((value) {
  ///  print(value.data['articles'][0]['title']);
    business = value.data['articles'];

    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    //print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'a568325f53c041ccb362e8c6cf18dcd1',
      },
    ).then((value) {
      ///  print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'a568325f53c041ccb362e8c6cf18dcd1',
      },
    ).then((value) {
      ///  print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
     // print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }


  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey':'a568325f53c041ccb362e8c6cf18dcd1',
      },
    ).then((value) {
      //  print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
 }