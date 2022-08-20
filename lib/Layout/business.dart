import 'package:api_app/Bloc/Cubit.dart';
import 'package:api_app/Bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Business extends StatelessWidget
{


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NavCubit,NavStates>(
      listener: (context, state) => NavCubit(),
      builder: (context, state)
      {
        var cubit = NavCubit.get(context);

        return cubit.business.isEmpty ? Center(child: CircularProgressIndicator()) : Container(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => cubit.listBuilder(context , index , cubit.business),
              itemCount: cubit.business.length,
            )
        ) ;
      },
    );
  }

}
