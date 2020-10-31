import 'package:flutter/material.dart';

import 'users_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Pagination Example'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Fetch Users'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UsersPage())),
          ),
        ),
      );
}
