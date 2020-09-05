import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/student.dart';
import 'package:seapp/screens/home/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Student>>(context) ?? [];

    return ListView.builder(itemCount: users.length, itemBuilder: (context, index) {
      return UserTile(student: users[index]);
    });
  }
}
