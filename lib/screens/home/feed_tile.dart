import 'package:flutter/material.dart';
import 'package:seapp/models/feed.dart';

class FeedTile extends StatelessWidget {

  final Feed feed;
  FeedTile({ this.feed });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/notification.png'),
          ),
          title: Text(feed.title),
          subtitle: Text('\n' + feed.by + '\n' + '\n' + feed.desc + '\n'),
          isThreeLine: true,
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
