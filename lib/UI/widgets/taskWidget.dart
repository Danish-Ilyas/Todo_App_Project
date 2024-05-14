import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todotask_hive/UI/utils/colors.dart';
import 'package:todotask_hive/UI/widgets/taskView.dart';
import 'package:todotask_hive/models/task.dart';


class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task,});

  final Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {


  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subTitle;
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
        super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            CupertinoPageRoute(builder: (ctx) => TaskView(
                titleTaskController: textEditingControllerForTitle,
                descriptionTaskController: textEditingControllerForSubTitle,
                task: widget.task
            ),
            ),
        );
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        duration: Duration(milliseconds: 600),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.task.isCompleted ?
            Color.fromARGB(154, 119, 144, 229)
                :Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: Offset(0,4),
                blurRadius: 10,
              )
            ]
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: (){
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              width: 50,
              duration: Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted ?
                MyColors.primaryColor
                    :Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey,width: .8),
              ),
              child: Icon(Icons.check,color: Colors.white,),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 5,top: 3),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                color: widget.task.isCompleted? MyColors.primaryColor
                  :Colors.black,
                fontWeight: FontWeight.w500,
                decoration:widget.task.isCompleted? TextDecoration.lineThrough
                : null,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                color: widget.task.isCompleted? MyColors.primaryColor
                    :Colors.black,
                fontWeight: FontWeight.w300,
                 decoration:widget.task.isCompleted? TextDecoration.lineThrough
                  :null,
              ),),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0,top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),
                        style: TextStyle(
                          fontSize: 14,
                          color:widget.task.isCompleted? Colors.white
                              :Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.task.isCompleted? Colors.white
                              :Colors.grey,

                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
