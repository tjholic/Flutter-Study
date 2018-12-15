import 'package:flutter/material.dart';
import 'FirstPage.dart' as first;
import 'SecondPage.dart' as second;
import 'ThirdPage.dart' as third;

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
        home: new MyTabs());
  }
}

class MyTabs extends StatefulWidget {
  @override
  MyTabState createState() => new MyTabState();
}

class MyTabState extends State<MyTabs> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pages"),
        backgroundColor: Colors.deepOrange,
        bottom: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(icon: new Icon(Icons.arrow_forward)),
          new Tab(icon: new Icon(Icons.arrow_downward)),
          new Tab(icon: new Icon(Icons.arrow_back))
        ]),
      ),
//      bottomNavigationBar: new Material(
//          color: Colors.deepOrange,
//          child: new TabBar(controller: controller, tabs: <Tab>[
//            new Tab(icon: new Icon(Icons.arrow_forward)),
//            new Tab(icon: new Icon(Icons.arrow_downward)),
//            new Tab(icon: new Icon(Icons.arrow_back))
//          ])),
      body: new TabBarView(controller: controller, children: <Widget>[
        new first.First(),
        new second.Second(),
        new third.Third()
      ]),
    );
  }
}
