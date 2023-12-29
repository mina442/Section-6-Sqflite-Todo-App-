import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_udemy/shared/components/components.dart';
import 'package:todo_app_udemy/shared/cubit/cubit.dart';
import 'package:todo_app_udemy/shared/cubit/states.dart';

class Archived extends StatelessWidget {
  const Archived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
          
      },
      builder: (context, state) {
        var tasks= AppCubit.get(context).archivedTasks;
      return TasksBuilder(tasks: tasks,);});
   
  }
}
