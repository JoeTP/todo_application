import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/cubit/states.dart';

import '../components/constants.dart';
import '../pages/models/archive_task.dart';
import '../pages/models/done_task.dart';
import '../pages/models/new_task.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// class ToDoCubit extends Cubit<ToDoStates> {
//   ToDoCubit() : super(InitialState());
//
//   static ToDoCubit get(context) => BlocProvider.of(context);
//
//   List<Widget> screens = [
//     NewTasks(),
//     DoneTasks(),
//     ArchiveTasks(),
//   ];
//
//     List<BottomNavigationBarItem> bottomItems = [
//     BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Today'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.check_circle_outline), label: 'Done'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.archive_outlined), label: 'Archive'),
//   ];
//
//   List<Map> newTasks = [];
//   List<Map> doneTasks = [];
//   List<Map> archiveTasks = [];
//
//   List<String> titles = [
//     "New Tasks",
//     "Done Tasks",
//     "Archived Tasks",
//   ];
//     bool bottomSheetShow = false;
//
//   int currentIndex = 0;
//
//   void changeIndex(int index) {
//     currentIndex = index;
//     emit(ChangeBottomNavState());
//   }
//
//   Database? database;
//   void createDataBase() {
//     openDatabase(
//       'todo.db',
//       version: 1,
//       onCreate: (database, version) {
//         print('Database Created');
//         database
//             .execute(
//             'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
//             .then((value) {
//           print('Table created');
//         }).catchError((e) {
//           print('Error When Creating Table ${e.toString()}');
//         });
//       },
//       onOpen: (database) {
//         getDataFromDataBase(database);
//       },
//     ).then((value) {
//       database = value;
//       emit(CreateDatabaseState());
//     });
//   }
//
//   insertToDataBase({
//     required String title,
//     required String time,
//     required String date,
//   }) async {
//     await database!.transaction((txn) async {
//       txn
//           .rawInsert(
//           'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
//           .then((value) {
//         print('$value Table insered seccesfuly');
//         emit(InsertDatabaseState());
//         getDataFromDataBase(database);
//       }).catchError((e) {
//         print(' Error When Inserting Table ${e.toString()}');
//       });
//     });
//   }
//
//   void getDataFromDataBase(database) {
//     newTasks = [];
//     doneTasks = [];
//     archiveTasks = [];
//
//     emit(GetDatabaseState());
//     database!.rawQuery('SELECT * FROM tasks').then((value) {
//       value.forEach((element) {
//         if (element['status'] == 'New') {
//           newTasks.add(element);
//         } else if (element['status'] == 'done') {
//           doneTasks.add(element);
//         } else
//           archiveTasks.add(element);
//       });
//
//       print(value);
//
//       emit(GetDatabaseState());
//     });
//   }
//
//   IconData fabIcon = Icons.edit;
//   bool isBottonSheetShown = false;
//
//   void changeBottomSheetState({
//     required bool isShow,
//     required IconData icon,
//   }) {
//     isBottonSheetShown = isShow;
//     fabIcon = icon;
//     emit(ChangeBottomSheetState());
//   }
//
//   void updateDataBase({
//     required String status,
//     required int id,
//   }) async {
//     database!.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
//         ['$status', id]).then((value) {
//       getDataFromDataBase(database);
//       emit(UpdateDatabaseState());
//     });
//   }
//
//   // void deleteData({
//   //   required int id,
//   // }) async {
//   //   database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
//   //     getDatabase(database);
//   //     emit(AppDeleteDatabaseState());
//   //   });
//   // }
// }







class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(InitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  //Logic is HERE
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Today'),
    BottomNavigationBarItem(
        icon: Icon(Icons.check_circle_outline), label: 'Done'),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined), label: 'Archive'),
  ];

  List screens = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  List titles = [
    'New Task',
    'Done Task',
    'Archive Task',
  ];

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  IconData fabIcon = Icons.edit;

  bool bottomSheetShow = false;

  void changeBottomSheetState({
    required IconData icon,
    required bool isShow,
  }) {
    bottomSheetShow = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

  bool isChecked = false;

  void checkIsDone() {
    isChecked != isChecked;
    emit(TaskIsCheckedState());
  }

  ///DataBase Functions
  ///Create empty list and Database Variable

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  late Database db;

  ///1: Create database
  void createDataBase() {
    openDatabase('my_db.db', version: 1, onCreate: (Database db, int version) {
      // When creating the db, create the table
      db
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('DB open error: ${error.toString()}');
      });
    }, onOpen: (db) {
      print(newTasks);

      getDataFromDataBase(db);

      print('Data Base Opened');
    }).then((value) {
      db = value;
      emit(CreateDatabaseState());
    });
  }

  ///2: insert database which has inside of it the getDatabase Fn
  // insertToDataBase({
  //   required title,
  //   required date,
  //   required time,
  // }) async {
  //   return await db.transaction((txn) async {
  //     await txn
  //         .rawInsert(
  //             'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
  //         .then((value) {
  //       print('$value inserted successfully');
  //       emit(InsertDatabaseState());
  //
  //       getDataFromDataBase(db);
  //     }).catchError((error) {
  //       print('DB insert error: ${error.toString()}');
  //     });
  //
  //     return null;
  //   });
  // }
  Future insertToDataBase({
    required date, required title, required time
  }) async {
    return await db.transaction((txn) => txn
        .rawInsert(
        'INSERT INTO tasks (date, title, time, status) VALUES("${date}", "${title}", "${time}", "new")')
        .then((value) {
      print("$value Inserted Successfully");
      emit(InsertDatabaseState());
      getDataFromDataBase(db);
    }).catchError((error) {
      print("Record did not inserted ${error.toString()}");
    }));
  }



  ///3: Get DataBase
  // void getDataFromDataBase(db) {
  //   newTasks = [];
  //   doneTasks = [];
  //   archiveTasks = [];
  //   emit(GetDatabaseState());
  //
  //   db!.rawQuery('SELECT * FROM tasks').then((value) {
  //     value.forEach((element) {
  //       if (element['status'] == 'new') {
  //         newTasks.add(element);
  //       } else if (element['status'] == 'done') {
  //         doneTasks.add(element);
  //       } else {
  //         archiveTasks.add(element);
  //       }
  //     });
  //     emit(GetDatabaseState());
  //   });
  // }

  // void getDataFromDataBase(database) {
  //   newTasks = [];
  //   doneTasks = [];
  //   archiveTasks = [];
  //
  //   emit(GetDatabaseState());
  //   database!.rawQuery('SELECT * FROM tasks').then((value) {
  //     value.forEach((element) {
  //       if (element['status'] == 'new') {
  //         newTasks.add(element);
  //       } else if (element['status'] == 'done') {
  //         doneTasks.add(element);
  //       } else
  //         archiveTasks.add(element);
  //     });
  //
  //     print(value);
  //
  //     emit(GetDatabaseState());
  //   });
  // }
  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    // emit(ToDoGetReloadDatabase());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      emit(GetDatabaseState());

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else
          archiveTasks.add(element);
      });
    });
  }



  ///4: Updating DataBase then get DataBase again
  // void updateDataBase({
  //   required String status,
  //   required int id,
  // }) {
  //   db.rawUpdate(
  //     'UPDATE tasks SET status = ? WHERE id = ?',
  //     ['$status', id],
  //   ).then((value) {
  //     getDataFromDataBase(db);
  //     emit(UpdateDatabaseState());
  //   });
  // }

  void updateDataBase({
    required String status,
    required int? id,
  }) {
    db.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((
        value) {
      getDataFromDataBase(db);
      emit(UpdateDatabaseState());
    });
  }


  ///4: Deleting from DataBase then get DataBase again
  void deleteFromDataBase({
    required int id,
  }) async {
    db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(db);
      emit(DeleteFromDatabaseState());
    });
  }
}
