import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seapp/models/feed.dart';
import 'feed_tile.dart';

class FeedList extends StatefulWidget {
  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  Widget build(BuildContext context) {

    final feeds = Provider.of<List<Feed>>(context) ?? [];
    
    return ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return FeedTile(feed : feeds[index]);
        },
    );
  }
}
