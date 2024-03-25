// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:todo/domain/entity/group.dart';
import 'package:todo/domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  var taskText = '';
  int groupKey;
  
  TaskFormWidgetModel({required this.groupKey});

  void saveTasks(BuildContext context) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }

    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('group_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
