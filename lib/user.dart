import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List users;
  Map userData;
  Future setUser() async{
    String url = "https://reqres.in/api/users";
    http.Response response = await http.get(url);
  //  debugPrint(response.body);
    userData = json.decode(response.body);
    setState(() {
     users = userData['data'] ;
    });
  //  setState(() {
  //    users = json.decode(response.body); 
  //  });
  //  debugPrint(users.toString());
  }
  @override
  void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: ListView.builder(
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int i){
          return Card(
            child : Row(
              children: <Widget>[
           Container(
             child: CircleAvatar(
               backgroundImage: NetworkImage(users[i]['avatar']),),
             ),
           Container(
             child: Text("${users[i]['first_name']}"),
             )
              ],
            )
         

          );
        },
      )
    );
  }
}
