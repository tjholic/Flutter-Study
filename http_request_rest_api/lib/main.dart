import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {


    return new Scaffold(
        appBar: new AppBar(title: new Text("Fetch Data Example"), backgroundColor: Colors.deepOrange),
        body: new Center(
            child: FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Text(snapshot.data.title, textAlign: TextAlign.center,);
                  } else if(snapshot.hasError) {
                    return Text("${snapshot.error}", textAlign: TextAlign.center,);
                  }
                  return CircularProgressIndicator();
                }),
        )
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if(response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']
    );
  }
}
