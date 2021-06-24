import 'package:flutter/material.dart';
// video base: https://www.youtube.com/watch?v=vfF0-hZaKNM

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("0/800"),
            Text("Points"),
            SizedBox(height: 20, ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegate,
            )
          ],
        ),
      ),
    );
  }
}

