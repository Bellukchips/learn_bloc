import 'package:flutter/material.dart';
import 'package:infinite_list/posts/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          '${post.id}',
          style: textTheme.caption,
        ),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}
