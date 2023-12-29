import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app_udemy/shared/cubit/states.dart';
import 'package:todo_app_udemy/modules/archive/archived.dart';
import 'package:todo_app_udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app_udemy/modules/new_tasks/tasks_screen.dart';
import 'package:todo_app_udemy/shared/cubit/cubit.dart';

import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
 

  final _text = TextEditingController();
  bool _validate = false;

  // @override
  // void dispose() {
  //   _text.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase() ,
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context, state) {
          if(state is AppInsertDataBaseState){
             Navigator.pop(context);
             titleController.clear();
             dateController.clear();
             timeController.clear();
          }
        } ,
      builder: (context, state) { 
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDataBaseLoadingState  ,
            builder: (context) => cubit.screens[cubit.currentIndex],
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      // height: 120,
                      color: Colors.white,
          
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'add Task',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.indigo[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: titleController,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter time ';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter date ';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse('2030-01-01'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.insertDatabase(title:
                                        titleController.text,
                                       date: dateController.text,
                                        time:timeController.text,
                                        );
                                      // insertDatabase(
                                      //   date: dateController.text,
                                      //   status: statusController.text,
                                      //   time: timeController.text,
                                      //   title: titleController.text,
                                      // ).then((value) {
                                      //   getDataFromDatabase(database).then((value) {
                                      //    
                                      //     // setState(() {
                                      //     //   tasks = value;
                                      //     //   print(tasks);
                                      //     // });
                                      //   });
                                      // }).then((value) {
                                        // setState(() {
                                        //    titleController.clear();
                                        //     dateController.clear();
                                        //     timeController.clear();
                                        //     statusController.clear();
                                        // });
                                      // });
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  child: const Text('add'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          bottomNavigationBar: BottomNavigationBar( 
            selectedItemColor: Colors.white,
            backgroundColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
              BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done Tasks'),
              BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'archive')
            ]
            ,));
  },
  ),
            );}
        
        
 //  void createDatabase(){}
  //  void createDatabase(){}
          
  
          
          }
    
          
          