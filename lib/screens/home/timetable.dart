import 'dart:math';
import 'package:flutter/material.dart';
import 'package:seapp/models/user.dart';
import 'package:seapp/shared/loading.dart';
import 'package:seapp/services/database.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<String> weekdaysShort = ["M", "T", "W", "T", "F", "S", "S"];
  int _selectedDay = 0;

  List<Widget> _getWeekButtons() {
    List<Widget> widgets = [];
    for (int i = 0; i < weekdays.length; i++) {
      widgets.add(
        ButtonTheme(
            minWidth: 55.0,
            padding: EdgeInsets.zero,
            child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                onPressed: () => {
                  setState(() {
                    _selectedDay = i;
                  })
                },
                color: (i == _selectedDay) ? Colors.orange : Colors.white,
                child: Text(
                  weekdays[i],
                  style: TextStyle(
                      color: (i == _selectedDay) ? Colors.white : Colors.black),
                ))),
      );
    }
    return widgets;
  }

  List<Widget> _getSubjectCards(TimetableData todayTimeTable) {
    List<Widget> widgets = [];
    if (todayTimeTable.morning != null) {
      widgets.add(
        SubjectCard(
          fullName: todayTimeTable.morning,
          lecturerName:
          todayTimeTable.morningLecturer, // timetableData.lecturer
        ),
      );
    }

    if (todayTimeTable.evening != null) {
      widgets.add(
        SubjectCard(
          fullName: todayTimeTable.evening,
          lecturerName:
          todayTimeTable.eveningLecturer, // timetableData.lecturer
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: _getWeekButtons()),
        StreamBuilder<TimetableData>(
            stream: DatabaseService(day: weekdays[_selectedDay].toLowerCase())
                .timetableData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: _getSubjectCards(snapshot.data));
              } else {
                return Loading();
              }
            })
      ],
    );
  }
}

class RandomMaterialColor {
  List<Color> materialColors = [
    Colors.red[800],
    Colors.blue[800],
    Colors.blue[800],
    Colors.green[800],
    Colors.purple[800]
  ];

  static final _random = Random();

  Color colorRandom() {
    return materialColors[_random.nextInt(materialColors.length)];
  }
}

class SubjectCard extends StatelessWidget {
  final String fullName;
  final String lecturerName;

  const SubjectCard({this.fullName, this.lecturerName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: RandomMaterialColor().colorRandom(),
          child: Text(
            fullName.split("-")[0].trim(),
            style: TextStyle(color: Colors.white, fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(
          fullName.split("-")[1].trim(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(lecturerName),
      ),
    );
  }
}
