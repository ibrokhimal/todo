import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TasksWidgetModel(groupKey: _model!.groupKey),
        child: const _TasksWidgetBody());
  }
}

class _TasksWidgetBody extends StatelessWidget {
  const _TasksWidgetBody();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksWidgetModel>();
    final title = model.group?.name ?? 'Task';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: const _TasksListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget();

  @override
  Widget build(BuildContext context) {
    final groupsCount = context.watch<TasksWidgetModel>().tasks().length;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _TasksListRowWidget(indexInList: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: groupsCount,
    );
  }
}

class _TasksListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TasksListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TasksWidgetModel>();
    final tasks = model.tasks()[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [          
          SlidableAction(
            onPressed: (_) => model.deleteTask(indexInList),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(tasks.text),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}

