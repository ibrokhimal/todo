import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/domain/entity/group.dart';

class GroupFormWidgetModel extends ChangeNotifier {
  var groupName = '';

  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    
    final group = Group(name: groupName);
    await box.add(group);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
