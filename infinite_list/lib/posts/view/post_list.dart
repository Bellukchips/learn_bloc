import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/posts/posts.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  //
  final _scrollController = ScrollController();
  PostBloc _postBloc;
  //

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFetched());
  }

  //is bottom
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text('failed to fetch posts'),
            );
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('No has data'),
              );
            }
            return ListView.builder(itemBuilder: (context, index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostListItem(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax ? state.posts.length : state.posts.length +1,
            controller: _scrollController,);
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
