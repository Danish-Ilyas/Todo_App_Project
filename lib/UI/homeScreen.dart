import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todotask_hive/UI/utils/constanst.dart';
import 'package:todotask_hive/UI/utils/strings.dart';
import 'package:todotask_hive/UI/widgets/Fab.dart';
import 'package:todotask_hive/UI/widgets/HomeAppBar.dart';
import 'package:todotask_hive/UI/widgets/slider_drawer.dart';
import 'package:todotask_hive/UI/widgets/taskWidget.dart';
import 'package:todotask_hive/extensions/space_exs.dart';
import 'package:todotask_hive/main.dart';

import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueOfIndicator(List<Task> task){
    if(task.isNotEmpty){
      return task.length;
    }else{
      return 3;
    }
  }

  dynamic checkDoneTask(List<Task> tasks){
    int i = 0;
    for(Task doneTask in tasks){
      if(doneTask.isCompleted){
        i++;
      }
    }
    return i ;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          tasks.sort((a, b) => a.createdAtTime.compareTo(b.createdAtDate));

          return Scaffold(
            floatingActionButton: Fab(),
            backgroundColor: Colors.white,
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 1000,
              slider: CustomDrawer(),
              appBar: HomeAppBar(
                drawerKey: drawerKey,
              ),
              child: _buildHomeBody(
                textTheme,
                base,
                tasks,
              ),
            ),
          );
        });
  }

  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular indicator
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              25.w,

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('My Tasks', style: textTheme.displayLarge),
                  3.h,
                  Text(
                    "${checkDoneTask(tasks)} of ${tasks.length}",
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
          indent: 100,
        ),
        Expanded(
          // Use Expanded instead of SizedBox to allow ListView to take available space
          child: tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    return Dismissible(
                      direction: DismissDirection.horizontal,
                      onDismissed: (_) {
                        base.dataStore.deleteTask(task: task);
                      },
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          8.w,
                          Text(
                            "This task was deleted",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      key: Key(task.id),
                      child: TaskWidget(
                        task: task,
                      ),
                    );
                  },
                )
              :
              // If the list is empty
              Column(
                  children: [
                    FadeInUp(
                      from: 30,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset(lottieURL,
                            animate: tasks.isNotEmpty ? false : true),
                      ),
                    ),
                    Text(
                      MyString.doneAllTask,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
