import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/feed.dart';
import 'package:seapp/services/database.dart';

import 'feed_list.dart';

class Feeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Feed>>.value(
      value: DatabaseService().feeds,
      child: Scaffold(
        body: FeedList(),
      ),
    );
  }
}
