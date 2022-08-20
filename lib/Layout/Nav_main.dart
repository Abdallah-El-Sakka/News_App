import 'package:api_app/Bloc/Cubit.dart';
import 'package:api_app/Bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NavCubit, NavStates>(
      listener: (context, state) => NavCubit(),
      builder: (context, state)
      {
        var cubit = NavCubit.get(context);
        return Scaffold(
          appBar: cubit.isSearchIconPressed
              ?
          PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SafeArea(
              child: Container(
                margin: EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20,
                    top: 10,
                    bottom: 5
                ),
                child: TextFormField(
                  onChanged: (value)
                  {
                    cubit.getSearchData(value);
                    cubit.business = cubit.search;
                    cubit.sports = cubit.search;
                    cubit.science = cubit.search;
                    cubit.changeWhenTyping();
                  },
                  cursorColor: Colors.red,
                  style: TextStyle(
                    color: Colors.red
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                              color: Colors.deepOrange,
                              width: 2.0
                          )
                      ),
                      label: Text(
                          'Search',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      prefixIcon: Icon(Icons.search_rounded,color: Colors.grey,),
                      suffixIcon: IconButton(
                          iconSize: 18,
                          onPressed: ()
                          {
                            cubit.showSearchBar();
                            cubit.getBusinessData();
                            cubit.getScienceData();
                            cubit.getSportsData();
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.grey,)
                      )
                  ),
                ),
              ),
            ),
          )
              :
          AppBar(
            title: Row(
              children: [
                Text(cubit.titles[cubit.navIndex]),
                SizedBox(width: 20,),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.deepOrange,
                  size: 20,
                )
              ],
            ),
            actions:
            [
              Container(
                margin: EdgeInsetsDirectional.only(
                    end: 10
                ),
                child: IconButton(
                  onPressed: ()
                  {
                    cubit.changeTheme();
                  },
                  icon : cubit.isDark ? Icon(Icons.dark_mode_outlined) : Icon(Icons.dark_mode),
                  color: Colors.deepOrange,
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                    end: 10
                ),
                child: IconButton(
                  onPressed: ()
                  {

                    cubit.showSearchBar();

                  },
                  icon : Icon(Icons.search_rounded),
                  color: Colors.deepOrange,
                ),
              )
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.navIndex,
            onTap: (index)
            {
              cubit.changeNavIndex(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.insights,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_football_rounded),
                  label: 'Sports'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.biotech_rounded),
                  label: 'Science'
              ),
            ],
          ),
          body: cubit.screens[cubit.navIndex],
        );
      },
    );
  }

}
