import 'package:flutter/material.dart';
import 'package:seapp/models/module.dart';
import 'package:seapp/models/user.dart';
import 'package:seapp/services/database.dart';
import 'package:seapp/shared/loading.dart';

class TableTile extends StatelessWidget {
  final Module module;

  TableTile({this.module});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TimetableData>(
        stream: DatabaseService(day: 'tue').timetableData,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            TimetableData timetableData = snapshot.data;
            return DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Monday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tuesday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Wednesday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Thursday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Friday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Saturday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Sunday',
                      //style: TextStyle(backgroundColor: Colors.orangeAccent),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                      DataCell(Text(timetableData.morning)),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                      DataCell(Text(timetableData.evening)),
                    ],
                  ),
                ],
            );
          } else {
            return Loading();
          }
        });
  }
}
