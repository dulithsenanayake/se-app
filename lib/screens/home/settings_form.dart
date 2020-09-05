import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/user.dart';
import 'package:seapp/services/database.dart';
import 'package:seapp/shared/constants.dart';
import 'package:seapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentSno;
  String _currentNic;
  String _currentMob;
  String _currentGpa;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SignedUser>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            // ignore: missing_return
            builder: (context, snapshot) {
              UserData userData = snapshot.data;

              if (snapshot.hasData) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Account Settings',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 12.0),

                        ),
                        validator: (val) =>
                            val.isEmpty ? 'please enter your name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        initialValue: userData.sno,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Student No',
                            hintStyle: TextStyle(fontSize: 12.0)),
                        validator: (val) =>
                            val.isEmpty ? 'please enter your student no' : null,
                        onChanged: (val) => setState(() => _currentSno = val),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        initialValue: userData.nic,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'NIC',
                            hintStyle: TextStyle(fontSize: 12.0)),
                        validator: (val) =>
                            val.isEmpty ? 'please enter your nic' : null,
                        onChanged: (val) => setState(() => _currentNic = val),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        initialValue: userData.mob,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Mobile',
                            hintStyle: TextStyle(fontSize: 12.0)),
                        validator: (val) =>
                            val.isEmpty ? 'please enter your mobile no' : null,
                        onChanged: (val) => setState(() => _currentMob = val),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        initialValue: userData.gpa,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'GPA',
                            hintStyle: TextStyle(fontSize: 12.0)),
                        validator: (val) =>
                            val.isEmpty ? 'please enter your gpa' : null,
                        onChanged: (val) => setState(() => _currentGpa = val),
                      ),
                      RaisedButton(
                        color: Colors.blueGrey[900],
                        child: Text(
                          'Update Settings',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name,
                                _currentSno ?? userData.sno,
                                _currentNic ?? userData.nic,
                                _currentMob ?? userData.mob,
                                _currentGpa ?? userData.gpa
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}
