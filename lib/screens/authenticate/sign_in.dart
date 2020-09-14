import 'package:flutter/material.dart';
import 'package:seapp/services/auth.dart';
import 'package:seapp/shared/constants.dart';
import 'package:seapp/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.0,
        title: Text('Sign In to SE Official'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: IconTheme(
                data: new IconThemeData(color: Colors.white),
                child: Icon(Icons.person),
              ),
              label: Text('Sign Up',
              style: TextStyle(
                color: Colors.white
              ),
              ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Colors.red,
                decoration: textInputDecoration.copyWith(labelText: 'Email'),
                validator: (val) => val.isEmpty ? '* Required' : null,
                onChanged: (val) {
                  setState(() => {email = val});
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Colors.red,
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,

                validator: (val) => val.isEmpty ? '* Required' : null,
                onChanged: (val) {
                  setState(() => {password = val});
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blueGrey[900],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic res = await _auth.signInWithEmailAndPassword(email, password);
                    if(res == null) {
                      setState(() {
                        error = 'Could not Sign In';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
