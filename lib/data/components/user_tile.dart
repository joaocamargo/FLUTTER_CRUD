import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../provider/users.dart';
import '../../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.trim().isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.USER_FORM, arguments: user);
              },
              color: Colors.orange,
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                      title: Text('Excluir usuário'),
                      content: Text('Tem certeza?'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('Não'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text('Sim'),
                        ),
                      ]),
                ).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  }
                });
              },
              color: Colors.red,
              icon: const Icon(Icons.delete))
        ]),
      ),
    );
  }
}
