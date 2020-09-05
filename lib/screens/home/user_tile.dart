import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seapp/models/student.dart';

class UserTile extends StatelessWidget {
  final Student student;
  UserTile({this.student});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          title: Text(student.name),
          subtitle: Text(student.mob),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
