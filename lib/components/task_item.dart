import 'package:flutter/material.dart';
import 'package:todo_application/components/text_style.dart';
import 'package:todo_application/cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  final Map model;

  const TaskItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction){
        ToDoCubit.get(context).deleteFromDataBase(id: model['id']);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                child: Text('${model['time']}'),
                radius: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model['title']}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          // fontSize: 20
                          ),
                    ),
                    // MediumText(text: '${model['title']}',textOverflow: true,),
                    const SizedBox(
                      height: 2,
                    ),
                    SmallText(text: '${model['date']}'),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    ToDoCubit.get(context).updateDataBase(status: 'done',id: model['id']);
                  }, icon: const Icon(Icons.check_circle_outline)),
              IconButton(
                  onPressed: () {
                    ToDoCubit.get(context).updateDataBase(status: 'archive',id: model['id']);

                  }, icon: const Icon(Icons.archive_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
