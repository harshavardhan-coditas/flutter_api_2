import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List userData = [];
  bool isLoading = true;
  final String url = 'https://randomuser.me/api/?results=50';
  Future getData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );
    List data = jsonDecode(response.body)['results'];
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: userData == null ? 0 : userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Image(
                                width: 70.0,
                                height: 70.0,
                                image: NetworkImage(
                                    userData[index]['picture']['thumbnail'])),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  userData[index]['name']['first'] +
                                      '  ' +
                                      userData[index]['name']['last'],
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Text('Phone: ${userData[index]['phone']}'),
                              Text('Gender: ${userData[index]['gender']}')
                            ],
                          ))
                        ],
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
