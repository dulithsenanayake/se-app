import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:seapp/models/student.dart';
import 'package:seapp/screens/home/feeds.dart';
import 'package:seapp/screens/home/settings_form.dart';
import 'package:seapp/screens/home/timetable.dart';
import 'package:seapp/services/auth.dart';
import 'package:seapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:seapp/screens/home/user_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  final List<Widget> _children = [
    Feeds(),
    TimeTable(),
    UserList(),
  ];

  @override
  Widget build(BuildContext context) {
    void _showAccountSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: SettingsForm(),
            );
          });
    }

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return StreamProvider<List<Student>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SE Official',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          elevation: 0.0,
          actions: <Widget>[
            SizedBox(
              width: 40.0,
              child: FlatButton(
                child: IconTheme(
                  data: new IconThemeData(color: Colors.white),
                  child: Icon(Icons.account_circle),
                ),
                onPressed: () => _showAccountSettingsPanel(),
              ),
            ),
            SizedBox(
              child: FlatButton(
                child: IconTheme(
                  data: new IconThemeData(color: Colors.white),
                  child: Icon(Icons.power_settings_new),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ),
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          onItemSelected: onTabTapped,
          showElevation: true,
          selectedIndex: _currentIndex,
          // this will be set when a new tab is tapped

          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.rss_feed),
                title: Text('Feeds'),
                activeColor: Colors.blue,
                inactiveColor: Colors.blueGrey
            ),
            BottomNavyBarItem(
                icon: new Icon(Icons.school),
                title: new Text('Academic'),
                activeColor: Colors.green,
                inactiveColor: Colors.blueGrey
            ),
            BottomNavyBarItem(
                icon: new Icon(Icons.people),
                title: new Text('People'),
                activeColor: Colors.red,
                inactiveColor: Colors.blueGrey
            )
          ],
        ),
      ),
    );
  }
}
