import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/group_edit_form/group_edit_form_widget_model.dart';
import 'package:todo/widgets/group_form/group_form_widget_model.dart';

class GroupEditFormWidget extends StatefulWidget {
  const GroupEditFormWidget({super.key});

  @override
  State<GroupEditFormWidget> createState() => _GroupEditFormWidgetState();
}

class _GroupEditFormWidgetState extends State<GroupEditFormWidget> {
  GroupEditFormWidgetModel? _model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = GroupEditFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupEditFormWidgetModel(groupKey: _model?.groupKey ?? 0),
      child: const _GroupEditFormWidgetBody(),
    );
  }
}

class _GroupEditFormWidgetBody extends StatelessWidget {
  const _GroupEditFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _GroupNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.watch<GroupFormWidgetModel>().saveGroup(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GroupEditFormWidgetModel>();
    final title = model.groupNameInit;
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'title',
      ),
      onChanged: (value) => model.groupName = value,
      onEditingComplete: () => model.saveGroup(context),
    );
  }
}
