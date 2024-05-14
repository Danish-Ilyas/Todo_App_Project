//? CodeWithFlexz on Instagram

//* AmirBayat0 on Github
//! Programming with Flexz on Youtube

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotask_hive/UI/homeScreen.dart';
import 'package:todotask_hive/UI/widgets/taskviewAppBar.dart';
import 'package:todotask_hive/data/HiveDataStore.dart';
import 'package:todotask_hive/models/task.dart';

import 'UI/widgets/taskView.dart';
Future<void> main()async{

  await Hive.initFlutter();
  //register the hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());
  //open a box
  var box = await Hive.openBox<Task>(HiveDataStore.boxName);
  
  box.values.forEach(
    (task) {
    if(task.createdAtTime.day != DateTime.now().day){
      task.delete();
    }else{
     //do nothing
    }});
  runApp(BaseWidget(child: MyApp()));
}

class BaseWidget extends InheritedWidget{
  BaseWidget({
    required this.child,
    Key? key,
}) : super(key: key,child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context){
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if(base != null){
      return base;
    }else{
      throw StateError('Could not find ancestor widget of type base');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          headline3: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headline4: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headline5: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          subtitle2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
     //home:  HomeScreen(),
      home: HomeScreen(),
    );
  }
}
