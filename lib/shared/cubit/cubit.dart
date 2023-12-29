import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_udemy/modules/archive/archived.dart';
import 'package:todo_app_udemy/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app_udemy/modules/new_tasks/tasks_screen.dart';
import 'package:todo_app_udemy/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [Tasks(), DoneTasks(), Archived()];
  List<String> titles = ['Tasks', 'Done Tasks', 'Archived'];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Map> newTasks = [];
  Database? database;
  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (db, version) {
      db.execute('''
  CREATE TABLE "tasks" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "time" TEXT NOT NULL,
    "status" TEXT NOT NULL
  )
 ''').then((value) {
        print('create=====');
      }).catchError((error) {
        print('error when creating table is ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('opened=====');
    }).then((value) {
      database = value;
    });
    emit(AppCreateDataBaseState());
  }

  Future insertDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database!.transaction((txn) async {
      await txn.rawInsert('''INSERT INTO tasks('title','date','time' ,'status')
     VALUES("$title", "$date","$time ", "new")''').then((value) {
        print('$value Insert=========');
        emit(AppInsertDataBaseState());
        getDataFromDatabase(database);
      }).catchError((Error) {
        print('error when Insert table is ${Error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)  {
   newTasks = [];
   doneTasks = [];
   archivedTasks = [];
   
    emit(AppGetDataBaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      
      emit(AppGetDataBaseState());
     print(newTasks);
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id  = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }
   void deleteData({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id  = ?',
        [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  //  mydeleteDatabase() async {
  //   String databasepath = await getDatabasesPath();
  //   String path = join(databasepath, 'todo.db');
  //   await deleteDatabase(path);
  //   print('delete===');
  // }

}
