import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskFormWidgetModel(groupKey: _model?.groupKey ?? 0),
      child: const _TasksFormWidgetBody(),
    );
  }
}

class _TasksFormWidgetBody extends StatelessWidget {
  const _TasksFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _TaskTextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TaskFormWidgetModel>().saveTasks(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<TaskFormWidgetModel>();
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Add new task',
      ),
      onChanged: (value) => model.taskText = value,
      onEditingComplete: () => model.saveTasks(context),
    );
  }
}
