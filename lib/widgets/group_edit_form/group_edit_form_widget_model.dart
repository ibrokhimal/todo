// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/domain/entity/group.dart';

class GroupEditFormWidgetModel extends ChangeNotifier {
  // ignore: prefer_final_fields
  var groupName = '';
  int groupKey;
  
  GroupEditFormWidgetModel({
    required this.groupKey,
  });

  Future<String> showForm() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    return box.getAt(groupKey).toString();
  }

  String groupNameInit(){
    
    return showForm() as String;
  }
  
  
  void saveGroup(BuildContext context) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    
    final group = Group(name: groupName);
    await box.putAt(groupKey, group);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
