import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../components/task_item.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class DoneTasks extends StatelessWidget {
  DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = ToDoCubit.get(context).doneTasks;

          return ListView.separated(
            itemBuilder: (context, index) => TaskItem(
              model: tasks[index],
            ),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: tasks.length,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          );
        });
  }
}
