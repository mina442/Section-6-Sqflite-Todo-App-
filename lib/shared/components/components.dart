import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_udemy/shared/cubit/cubit.dart';
Widget buildTaskItem(Map model,context ) =>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id:model['id']);
  },
  child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded (
              child: Column(
                mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 18.0,  fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',style: TextStyle(color: Colors.grey),
              )  ],
              ),
            )
          ,SizedBox(
              width: 20.0, 
            ),
            IconButton(onPressed: (){
              AppCubit.get(context).updateData(status:  'new', id: model['id']);
            }, icon: Icon(Icons.list,color: Colors.blue, ),)
            ,IconButton(onPressed: (){
              AppCubit.get(context).updateData(status:  'done', id: model['id']);
            }, icon: Icon(Icons.check_circle,color: Colors.green, ),)
             ,IconButton(onPressed: (){
              AppCubit.get(context).updateData(status:  'archive', id: model['id']);
             }, icon: Icon(Icons.archive, color: Colors.grey , ))],
        ),
      ),
);
Widget TasksBuilder({
  required  List<Map> tasks
}) => ConditionalBuilder(
           condition: tasks.length > 0, 
            fallback: (BuildContext context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list),
                  Text('No Tasks Yet , Please Add Some Tasks')
                ],
              ),
            ),
            builder: (BuildContext context)=> ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (BuildContext context, int index) => 
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemBuilder: (BuildContext context, int index) =>
                  buildTaskItem(tasks[index], context),
            )
          );
         