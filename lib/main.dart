import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/widgets/group_edit_form/group_edit_form_widget.dart';
import 'package:todo/widgets/group_form/group_form_widget.dart';
import 'package:todo/widgets/groups/groups_widget.dart';
import 'package:todo/widgets/task_form/task_form_widget.dart';
import 'package:todo/widgets/tasks/tasks_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Todo List',
      routes: {
        '/groups': (context)=> const GroupsWidget(),
        '/groups/form': (context)=> const GroupFormWidget(),
        '/groups/form_edit': (context)=> const GroupEditFormWidget(),
        '/groups/tasks': (context)=> const TasksWidget(),
        '/groups/task_form': (context)=> const TaskFormWidget(),
      },
      initialRoute: '/groups',
    );
  }
}