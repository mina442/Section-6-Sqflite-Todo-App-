import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_udemy/CounterScreen/cubit/cubit.dart';
import 'package:todo_app_udemy/CounterScreen/cubit/states.dart';
 class CounterScreen extends StatelessWidget { 
   @override
   Widget build(BuildContext context) {
    // CounterCubit cubit= BlocProvider.of(context);
    // var c =CounterCubit.get(context); 
     return BlocProvider( 
       create: (BuildContext context) => CounterCubit() ,
       child: BlocConsumer<CounterCubit,CounterStates>(
        listener:  (context, state) {
          if(state is CounterInitialState) print('Initial State ');
          if(state is CounterPlusState) print('Plus State${state.Container}');
          if(state is CounterMinusState) print('Minus State ${state.Container}');
        },
        builder: (context, state) {
         return Scaffold(
          appBar: AppBar(
            title: Text('CounterScreen')
            ,actions: [],),
            body: Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                      CounterCubit.get(context).Plus();
                      print(Container);
                  }, child: Text('plus'))
                  ,Padding(padding:
                   const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '${CounterCubit.get(context).Container}',
                  style: TextStyle(fontSize: 50,
                  fontWeight: FontWeight.w900),),),
                   TextButton(onPressed: (){
                     CounterCubit.get(context).Minus();
                      print(Container);
                  }, child: Text('minus'))
                  ,
                ],
              ) 
              )
         );}
       ),
     );

//  
   }
   }