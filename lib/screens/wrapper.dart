import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/user.dart';
import 'package:seapp/screens/authenticate/authenticate.dart';
import 'package:seapp/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<SignedUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
