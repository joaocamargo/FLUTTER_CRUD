import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _itens = {...DUMMY_USERS};

  List<User> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  User byIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void remove(User user) {
    if (user.id != null && user.id!.trim().isNotEmpty) {
      _itens.remove(user.id);
      notifyListeners();
    }
  }

  void put(User user) {
    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _itens.containsKey(user.id)) {
      _itens.update(user.id!, (_) => user);
    } else {
      final id = Random().nextDouble().toString();
      _itens.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    }
    notifyListeners();
  }
}
