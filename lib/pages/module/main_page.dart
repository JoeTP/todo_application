import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/cubit/cubit.dart';
import 'package:todo_application/cubit/states.dart';
import 'package:todo_application/pages/models/archive_task.dart';
import 'package:todo_application/pages/models/done_task.dart';
import 'package:todo_application/pages/models/new_task.dart';

import '../../components/components.dart';
import '../../components/constants.dart';

class HomePage extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //create db on the instant of opening the application
      create: (context) => ToDoCubit()..createDataBase(),
      child: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (BuildContext context, ToDoStates state) {
          if (state is InsertDatabaseState) Navigator.pop(context);
        },
        builder: (BuildContext context, ToDoStates state) {
          ToDoCubit cubit = ToDoCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.bottomItems,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.bottomSheetShow) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDataBase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                    //     .then((value) {
                    //       // if future error: watch video 86-Database with cubit @16:00
                    //   cubit.getDataFromDataBase(cubit.db).then((value) {
                    //     cubit.tasks = value;
                    //     Navigator.pop(context);
                    //   });
                    //   cubit.bottomSheetShow = false;
                    //     cubit.fabIcon = Icons.add;
                    //
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultFormField(
                                  controller: titleController,
                                  isPassword: false,
                                  label: 'Task title',
                                  type: TextInputType.text,
                                  prefix: Icons.title,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultFormField(
                                  controller: timeController,
                                  isPassword: false,
                                  label: 'Task Time',
                                  type: TextInputType.datetime,
                                  prefix: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context);
                                    });
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultFormField(
                                  controller: dateController,
                                  isPassword: false,
                                  label: 'Task Date',
                                  type: TextInputType.datetime,
                                  prefix: Icons.calendar_month,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-05-03'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        icon: Icons.edit, isShow: false);
                  });
                  cubit.changeBottomSheetState(icon: Icons.add, isShow: true);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
          );
        },
      ),
    );
  }
}
