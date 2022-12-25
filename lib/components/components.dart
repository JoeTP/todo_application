import 'package:flutter/material.dart';
import 'package:todo_application/components/constants.dart';
import 'package:todo_application/components/text_style.dart';
import 'package:todo_application/cubit/cubit.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator? validate;
  final VoidCallback? pressSuffix;
  final IconData? prefix;
  final IconData? suffix;
  final bool readOnly;

  bool isPassword = false;
  bool enable;

  DefaultFormField({
    Key? key,
    required this.controller,
    required this.isPassword,
    required this.label,
    required this.type,
    this.onSubmit,
    this.readOnly = false,
    this.onChanged,
    this.validate,
    this.onTap,
    this.prefix,
    this.pressSuffix,
    this.suffix,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          onPressed: pressSuffix,
          icon: Icon(suffix),
        ),
      ),
    );
  }
}



// class BuildTaskItem extends StatelessWidget {
//   final Map model;
//
//   const BuildTaskItem(this.model);
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: Key(model['id'].toString()),
//       onDismissed: (direction) {
//         ToDoCubit.get(context).deleteFromDataBase(
//           id: model['id'],
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40.0,
//               child: Text(
//                 '${model['time']}',
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     '${model['title']}',
//                     style: Theme.of(context).textTheme.bodyText2,
//                   ),
//                   Text(
//                     '${model['date']}',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.check_box_sharp,
//                 color: Colors.green,
//               ),
//               onPressed: () {
//                 ToDoCubit.get(context).updateDataBase(
//                   status: 'done',
//                   id: model['id'],
//                 );
//               },
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.archive,
//                 color: Colors.black45,
//               ),
//               onPressed: () {
//                 ToDoCubit.get(context).updateDataBase(
//                   status: 'archived',
//                   id: model['id'],
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }




Widget BuildTaskItem(Map model,context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        child: Text(
          "${model['time']}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${model['title']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              "${model['date']}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 20,
      ),
      IconButton(
          icon: Icon(
            Icons.check_box,
            color: Colors.green,
          ), onPressed: (){
        ToDoCubit.get(context).updateDataBase(status: 'done', id: model['id']);
      }),
      IconButton(
          icon: Icon(
            Icons.archive_rounded,
            color: Colors.black45,
          ), onPressed: (){
        ToDoCubit.get(context).updateDataBase(status: 'archive', id: model['id']);
      }),
    ],
  ),
);



