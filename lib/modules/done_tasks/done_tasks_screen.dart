import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_udemy/shared/components/components.dart';
import 'package:todo_app_udemy/shared/cubit/cubit.dart';
import 'package:todo_app_udemy/shared/cubit/states.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
          
      },
      builder: (context, state) {
        var tasks= AppCubit.get(context).doneTasks;
      return TasksBuilder(tasks: tasks,);});
   
  }
}
