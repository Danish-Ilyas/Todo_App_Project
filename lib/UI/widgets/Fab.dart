import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todotask_hive/UI/widgets/taskView.dart';

class Fab extends StatefulWidget {
  const Fab({super.key});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_) =>TaskView(titleTaskController: null, descriptionTaskController: null, task: null,)));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 20,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
}
