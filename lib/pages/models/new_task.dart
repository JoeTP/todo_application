import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/components/task_item.dart';
import 'package:todo_application/components/text_style.dart';
import 'package:todo_application/cubit/cubit.dart';
import 'package:todo_application/cubit/states.dart';

class NewTasks extends StatelessWidget {
  NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Map<dynamic,dynamic>> tasks = ToDoCubit.get(context).newTasks;

          return ListView.separated(
            itemBuilder: (context, index) => TaskItem(model: tasks[index]),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: tasks.length,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          );
        });
  }
}
