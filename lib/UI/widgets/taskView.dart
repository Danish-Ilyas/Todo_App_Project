import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todotask_hive/UI/utils/colors.dart';
import 'package:todotask_hive/UI/utils/constanst.dart';
import 'package:todotask_hive/UI/utils/strings.dart';
import 'package:todotask_hive/UI/widgets/DateTimeSelection.dart';
import 'package:todotask_hive/UI/widgets/RepTextField.dart';
import 'package:todotask_hive/UI/widgets/taskviewAppBar.dart';
import 'package:todotask_hive/extensions/space_exs.dart';
import 'package:todotask_hive/main.dart';

import '../../models/task.dart';
class TaskView extends StatefulWidget {
   TaskView({super.key,
     required this.titleTaskController, required this.descriptionTaskController, required this.task});

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;


  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  bool isTaskAlreadyExist(){
    if(widget.titleTaskController?.text == null
    && widget.descriptionTaskController?.text == null){
      return true;
    }else return false;
  }
//show time

  String showTime(DateTime? time){
    if(widget.task?.createdAtTime == null){
      if(time == null){
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      }else{
        return DateFormat('hh:mm a').format(time).toString();
      }
    }else{
      return DateFormat('hh:mm a').format(widget.task!.createdAtTime).toString();
    }
  }

  //show date
  String showDate(DateTime? date){
    if(widget.task?.createdAtDate == null){
      if(date == null){
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      }else{
        return DateFormat.yMMMEd().format(date).toString();
      }
    }else{
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  //show selected date
  DateTime showDateAsDateTime(DateTime? date){
  if(widget.task?.createdAtDate == null){
    if(date == null){
      return DateTime.now();
    }else{
      return date;
    };
  }else{
    return widget.task!.createdAtDate;
  }
  }
//delete task
  dynamic deleteTask(){
    return widget.task?.delete();
  }

  //creating new task or updating the existing tasks
  dynamic isTaskAlreadyExistsUpdateOtherWiseCreate(){
    if(widget.titleTaskController?.text != null &&
    widget.descriptionTaskController?.text != null
    ){
      try{
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subTitle;

        widget.task?.save();
        Navigator.pop(context);
      }catch(e){
        updateTaskWarning(context);
      }
    }else{
      if(title != null && subTitle != null){
        var task = Task.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      }else{
        emptyWarning(context);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:Size.fromHeight(30),
            child: TaskViewAppBar()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildSizedBox(textTheme),

              _buildMainTaskActivity(textTheme, context),
              
              _buildBottomSideButton(),
            ],
          ),
        )
      ),
    );
  }
// delete and add new task button
  Padding _buildBottomSideButton() {
    return Padding(padding: EdgeInsets.only(bottom: 10,top: 20),
              child: Row(
                mainAxisAlignment: isTaskAlreadyExist()? MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
                children: [
                  isTaskAlreadyExist() ? Container() :
                  MaterialButton(onPressed: (){
                    deleteTask();
                    Navigator.pop(context);
                    },
                    minWidth: 150,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    height: 55,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.close,color: MyColors.primaryColor,),
                        5.w,
                        Text(MyString.deleteTask,style: TextStyle(color: MyColors.primaryColor),),
                      ],
                    ),
                  ),
                  MaterialButton(onPressed: (){
                    isTaskAlreadyExistsUpdateOtherWiseCreate();
                  },
                    minWidth: 150,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    height: 55,
                    color: MyColors.primaryColor,
                    child: Text(
                      isTaskAlreadyExist()?
                      MyString.addTaskString
                      :MyString.updateTaskString,
                      style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
            );
  }


// date time selection code snippet
  SizedBox _buildMainTaskActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
              width: double.infinity,
              height: 400,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(MyString.titleOfTitleTextField,style: textTheme.headlineMedium,),
                  ),
                RepoTextField(controller: widget.titleTaskController,
                  onFieldSubmitted: (String inputTitle) {
                  title = inputTitle;
                  },
                  onChange: (String inputTitle) {
                    title = inputTitle;
                  },),
                    10.h,
                RepoTextField(controller: widget.descriptionTaskController,isForDescription: true,
                  onFieldSubmitted: (String inputSubTitle) {
                  subTitle = inputSubTitle;
                  },
                  onChange: (String inputSubTitle) {
                    subTitle = inputSubTitle;
                  },),
                  DateTimeSelection(onTap: () {

                    showModalBottomSheet(context: context, builder: (_)=>SizedBox(
                      height: 280,
                      child: TimePickerWidget(
                      onChange: (_,__){

                      },
                        initDateTime: showDateAsDateTime(time),
                      dateFormat: 'HH:mm',
                      onConfirm: (dateTime,_){
                        setState(() {
                          if(widget.task?.createdAtTime == null){
                            time = dateTime;
                          }else{
                            widget.task!.createdAtTime = dateTime;
                          }
                        });
                      },
                    ),
                  ));
                    }, title: MyString.timeString,
                    time: showTime(time),
                    isTime: true,
                  ),
//Date selection
                    DateTimeSelection(onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        initialDateTime: showDateAsDateTime(date),
                        dateFormat: 'dd,MMM,yyyy',
                        maxDateTime: DateTime(2030, 4, 5),
                        minDateTime: DateTime.now(),
                        onConfirm: (dateTime, selectedIndex) {
                          // Handle date confirmation
                          setState(() {
                            if(widget.task?.createdAtDate == null){
                              date = dateTime;
                            }else{
                              widget.task!.createdAtDate = dateTime;
                            }
                          });
                        },
                      );
                    }, title: MyString.dateString,
                      time: showDate(date),),


                ],
              ),
            );
  }



  SizedBox _buildSizedBox(TextTheme textTheme) {
    return SizedBox(
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                child: Divider(
                  thickness: 2,
                ),
              ),
              RichText(text: TextSpan(
                text: isTaskAlreadyExist()
                    ? MyString.addNewTask
                    :MyString.updateCurrentTask,
                children: [
                  TextSpan(
                    text: MyString.taskStrnig,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    )
                  )
                ],
                style: textTheme.titleLarge,)),
              SizedBox(
                width: 40,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ],
          ),
        );
  }
}
