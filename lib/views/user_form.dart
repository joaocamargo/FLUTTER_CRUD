import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/users.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user.id != null) {
      _formData['id'] = user.id.toString();
      _formData['name'] = user.name.toString();
      _formData['email'] = user.email.toString();
      _formData['avatarUrl'] = user.avatarUrl.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = const User(name: '', email: '', avatarUrl: '');

    final route = ModalRoute.of(context);

    if (route?.settings.arguments != null) {
      user = route!.settings.arguments as User;
    }

    //new User(avatarUrl: '', name: '', email: '');

    _loadFormData(user);

    if (kDebugMode) {
      //print(user.name);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulario Usuario',
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final isValid = _form.currentState?.validate();

                if (isValid != null && isValid) {
                  _form.currentState?.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'] ?? '',
                      name: _formData['name'] ?? 'n',
                      email: _formData['email'] ?? '',
                      avatarUrl: _formData['avatarUrl'] ?? '',
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nome inválido";
                    }

                    if (value.length <= 5) {
                      return "Nome curto";
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                    initialValue: _formData['email'],
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _formData['email'] = value!),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'URL Avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),
              ],
            )),
      ),
    );
  }
}
