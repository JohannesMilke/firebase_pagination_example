import 'package:firebase_pagination_example/providers/users_provider.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatefulWidget {
  final UsersProvider usersProvider;

  const ListViewWidget({
    @required this.usersProvider,
    Key key,
  }) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    widget.usersProvider.fetchNextUsers();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.usersProvider.hasNext) {
        widget.usersProvider.fetchNextUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        padding: EdgeInsets.all(12),
        children: [
          ...widget.usersProvider.users
              .map((user) => ListTile(
                    title: Text(user.name),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                  ))
              .toList(),
          if (widget.usersProvider.hasNext)
            Center(
              child: GestureDetector(
                onTap: widget.usersProvider.fetchNextUsers,
                child: Container(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
}
