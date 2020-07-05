import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String displayString = "0";

  Widget createButton(String title) {
    return Expanded(
      child: ButtonTheme(
        height: double.infinity,
        child: OutlineButton(
          onPressed: () {},
          child: Text (
              title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          borderSide: BorderSide(
            color: Color.fromARGB(140, 230, 181, 193),
            width: 0.5,
          ),
          highlightedBorderColor: Colors.black,
        ),
      ),
    );
  }

  Widget createRow(String name1, String name2, String name3, String name4) {
    return Expanded(
      child: Row(
        children: <Widget>[
          createButton(name1),
          createButton(name2),
          createButton(name3),
          createButton(name4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded (
              child: Container(
                color: Color.fromARGB(100, 224, 202, 207),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Text(
                      displayString,
                      style: TextStyle(
                        fontSize: 65,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  createRow("+", "-", "*", "/"),
                  createRow("7", "8", "9", "0"),
                  createRow("4", "5", "6", "CE"),
                  createRow("1", "2", "4", "0"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}