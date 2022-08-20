import 'package:api_app/Bloc/states.dart';
import 'package:api_app/Layout/business.dart';
import 'package:api_app/Layout/science.dart';
import 'package:api_app/Layout/sports.dart';
import 'package:api_app/Layout/wevView_screen.dart';
import 'package:api_app/shared_preferences/Cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Database/dio_helper.dart';

class NavCubit extends Cubit<NavStates>
{
  NavCubit() : super(NavInitialState());

  static NavCubit get(context) => BlocProvider.of(context);

  int navIndex = 0;

  List<String> titles =
  [
    'Business',
    'Sports',
    'Science',
  ];

  List<Widget> screens =
  [
    Business(),
    Sports(),
    Science(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  bool isDark = false;

  void checkForTheme(sharedBool)
  {
      if(sharedBool != null)
        {
          isDark = sharedBool;
        }
  }

  void changeTheme()
  {

      isDark = !isDark;

    CasheHelper.putData(key: 'theme', value: isDark)
        .then((value)
    {
      emit(ChangeThemeState());
    });
  }

  void changeNavIndex(index)
  {
    navIndex = index;

    if (index == 1) {
      getSportsData();
    }
    else if (index == 2) {
      getScienceData();
    }

    emit(NavChangeIndexState());
  }



  void getBusinessData()
  {
    emit(NavLoadingBusinessState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'us',
          'category': 'business',
          'apiKey': '167fe958677d4b0ba7445b893484ad00',
        }
    ).then((value)
    {

      business = value.data['articles'];
      emit(GetBusinessDataSuccessState());

    }).catchError((onError)
    {
      print(onError.toString());
      emit(GetBusinessDataErrorState());
    });
  }

  void getSportsData()
  {
    emit(NavLoadingSportsState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'us',
          'category': 'sports',
          'apiKey': '167fe958677d4b0ba7445b893484ad00',
        }
    ).then((value) {
      sports = value.data['articles'];


      emit(GetSportsDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetBusinessDataErrorState());
    });
  }

  void getScienceData()
  {
    emit(NavLoadingScienceState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country': 'us',
          'category': 'science',
          'apiKey': '167fe958677d4b0ba7445b893484ad00',
        }
    ).then((value) {
      science = value.data['articles'];


      emit(GetScienceDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetScienceDataErrorState());
    });
  }

  Widget listBuilder(context, index, list) =>
      InkWell(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(list[index]['url'])));
        },
        child: Container(
          margin: EdgeInsetsDirectional.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                ),
                child:list[index]['urlToImage'] == null ? Icon(Icons.error_outline_rounded,color: Colors.grey,size: 60,) : Image(image:NetworkImage(list[index]['urlToImage']),

                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsetsDirectional.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text(
                              list[index]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                list[index]['publishedAt'],
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.deepOrange.withOpacity(0.4)
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  )
              )
            ],
          ),
        ),
      );


  bool isSearchIconPressed = false;

  void showSearchBar()
  {
    isSearchIconPressed = !isSearchIconPressed;
    emit(ChangeBarForSearchState());
  }

  void getSearchData(String value)
  {

    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q': value,
          'apiKey': '167fe958677d4b0ba7445b893484ad00',
        }
    ).then((value)
    {
      search = value.data['articles'];
      emit(ChangeListForSearchState());

    });
  }

  void changeWhenTyping()
  {
    emit(ChangeListWhenTyping());
  }

}
