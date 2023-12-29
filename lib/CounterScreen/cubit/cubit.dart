import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_udemy/CounterScreen/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit():super(CounterInitialState());
  
  static CounterCubit get(context) => BlocProvider.of(context);

  int Container = 0 ;
  void Minus(){
    Container--;
    emit(CounterMinusState(Container));
  }
   void Plus(){
    Container++;
    emit(CounterPlusState(Container));
  }
}