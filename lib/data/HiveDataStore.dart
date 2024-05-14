import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todotask_hive/models/task.dart';

//All the crud operation for the hive database


class HiveDataStore{
  static const boxName = 'taskBox';

  final Box<Task> box = Hive.box<Task>(boxName);

  //add new task to box
Future<void> addTask({required Task task})async{
  await box.put(task.id, task);
}
//show task
Future<Task?> getTask({required String id})async{
  return box.get(id);
}
//update task
Future<void> updateTask({required Task task})async{
  await task.save();
}
//delete task
Future<void> deleteTask({required Task task})async{
  await task.delete();
}

//using this we can listen to the change and update the ui accordingly
ValueListenable<Box<Task>> listenToTask()=>box.listenable();




}