import 'package:fl02/services/http_service.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

class SecondScreen extends StatelessWidget {
  final httpService = new HttpService();

  @override
  build(BuildContext ctx) {
    return Scaffold(
      body: Container(
        color: Colors.blue[700],
        // TODO: почему не работает DefaultTextStyle в данном случае?
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: FutureBuilder(
            future: httpService.getUsers(),
            builder: (BuildContext ctx, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data;

                return ListView(
                  children: _usersListView(users, ctx),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<ListTile> _usersListView(List<User> users, BuildContext ctx) {
    return users.map((User user) => _getListTile(user, ctx)).toList();
  }

  ListTile _getListTile(User user, BuildContext ctx) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () => Navigator.of(ctx).pop(user),
    );
  }
}
