import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/module.dart';
import 'package:seapp/screens/home/module_list.dart';
import 'package:seapp/services/database.dart';

class TimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Module>>.value(
      value: DatabaseService().timetable,
      child: Scaffold(
        body: ModuleList(),
      ),
    );
  }
}
