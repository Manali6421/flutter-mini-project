import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puffzone/controller/user_controller.dart';
import 'package:puffzone/model/user.dart';

import 'package:puffzone/ui/add_user_screen/add_user.dart';
import 'package:puffzone/ui/user_detail_screen/user_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var showList = userListNew ?? userList;
  final StreamController<List<User>> _streamController = StreamController();
  UserController _userController = UserController();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        leading: Text(
          'P',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white60),
        ),
        actions: [
          FlatButton(
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUser()));
                _streamController.sink.add(_userController.getUser());
              },
              child: Text(
                'Want to add?',
                style: TextStyle(color: Colors.white60),
              ))
        ],
      ),
      body: StreamBuilder<List<User>>(
          stream: _streamController.stream,
          initialData: _userController.getUser(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 245, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          // print(userList.length);
                          User mapData = snapshot.data[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    child: FadeInImage.assetNetwork(
                                        image: mapData.avatar,
                                        placeholder: 'assets/logo.jpeg')),
                                title: Text(
                                  mapData.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  mapData.jobTitle,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.grey[700],
                                  onPressed: () {
                                    _userController.deleteUser(index);

                                    _streamController.sink
                                        .add(_userController.getUser());
                                  },
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetail(userData: mapData)));
                                },
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[300],
                                indent: 92,
                              )
                            ],
                          );
                        }),
                  ),
                );
              } else {
                return Center(
                    child: Text(
                  'No Record',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
