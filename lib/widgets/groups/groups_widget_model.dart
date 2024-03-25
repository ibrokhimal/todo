import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/domain/entity/group.dart';

class GroupsWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  GroupsWidgetModel() {
    _setup();
  }

  void editGroup(int index, BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form_edit', arguments: index);
  }

  void deleteGroup(int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(index);
  }

  void showForm(BuildContext context) {    
    Navigator.of(context).pushNamed('/groups/form');
  }

  void showTasks(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox<Group>('group_box');
    final groupKey = box.keyAt(index) as int;
    unawaited(
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/groups/tasks',arguments: groupKey),
    );
  }

  void readGroupsFormHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox<Group>('group_box');
    readGroupsFormHive(box);

    box.listenable().addListener(() => readGroupsFormHive(box));
  }
}
