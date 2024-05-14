import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskViewAppBar extends StatefulWidget {
  const TaskViewAppBar({super.key});

  @override
  State<TaskViewAppBar> createState() => _TaskViewAppBarState();
}

class _TaskViewAppBarState extends State<TaskViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
     child: Row(
       children: [
         Padding(
           padding: EdgeInsets.only(top: 20.0),
           child: GestureDetector(
               onTap: (){
                 Navigator.pop(context);
               },
               child: Icon(Icons.arrow_back_ios_new_rounded)),
         ),
       ],
     ),
    );
  }
}
