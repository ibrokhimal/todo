import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatelessWidget {
  const GroupFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GroupFormWidgetModel(),
      child: const _GroupFormWidgetBody(),
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Group'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _GroupNameWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<GroupFormWidgetModel>().saveGroup(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GroupFormWidgetModel>();
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Add new group',
      ),
      onChanged: (value) => model.groupName = value,
      onEditingComplete: () => model.saveGroup(context),
    );
  }
}
