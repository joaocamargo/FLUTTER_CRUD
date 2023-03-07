import 'package:flutter/material.dart';
import 'package:flutter_crud/data/components/user_tile.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de usuarios'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
                },
                color: Colors.white,
                icon: const Icon(Icons.add)),
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
        ));
  }
}
