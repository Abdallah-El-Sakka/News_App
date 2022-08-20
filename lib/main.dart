import 'package:api_app/Bloc/Cubit.dart';
import 'package:api_app/Bloc/states.dart';
import 'package:api_app/Database/dio_helper.dart';
import 'package:api_app/Layout/Nav_main.dart';
import 'package:api_app/shared_preferences/Cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async
{

  // make sure to wait for data to load then start the app
  // make app waiting for shared preferences data then start the app
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CasheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {

    bool? isDark = CasheHelper.prefs.getBool('theme');

    return BlocProvider(
      create: (BuildContext context) => NavCubit()..getBusinessData()..checkForTheme(isDark),
      child: BlocConsumer<NavCubit, NavStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'News App',

          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.6)
                  )
              ),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black.withOpacity(0.8)
                ),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20
                  )
              ),
              backgroundColor: Colors.white
          ),

          darkTheme: ThemeData(

              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.6)
                  )
              ),

              colorScheme: ColorScheme.dark(
                primary: Colors.deepOrange,
                background: Colors.deepOrange,
                secondary: Colors.deepOrange
              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('1C1C1C'),
                  unselectedItemColor: Colors.white.withOpacity(0.5)
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('232323'),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white.withOpacity(0.8)
                ),
                  backgroundColor: HexColor('232323'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20

                  )
              )
          ),

          themeMode: NavCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,

          home: MainScreen(),
        ),
      ),
    );
  }

}