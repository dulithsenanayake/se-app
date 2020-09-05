import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/module.dart';
import 'package:seapp/screens/home/table_tile.dart';

class ModuleList extends StatefulWidget {
  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  @override
  Widget build(BuildContext context) {
    final modules = Provider.of<List<Module>>(context) ?? [];

    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return TableTile(module: modules[index]);
        });
  }
}
