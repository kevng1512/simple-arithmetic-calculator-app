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
  String numberString = "0";
  String operation;
  double result = 0;
  bool shouldCalculate = false, afterEqual = false;

  Widget createButton(String title) {
    return Expanded(
      child: ButtonTheme(
        height: double.infinity,
        child: OutlineButton(
          onPressed: () => pressButton(title),
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

  pressButton (String title) {
    setState(() {
      try {
        if (title == '+' || title == '-' || title == '*' || title == '/') {
          if (shouldCalculate) {
            calculate();
          } else {
            result = double.parse(numberString);
            shouldCalculate = true;
          }
          operation = title;
          numberString = '';
        } else if (title == "CE") {
          displayString = "0";
          numberString = "";
          result = 0;
          operation = "";
          shouldCalculate = false;
        } else if (title == "=") {
          calculate();
          shouldCalculate = false;
          afterEqual = true;
        } else {
          if (numberString == "0" || numberString == '0.0') {
            numberString = '';
          }
          if (afterEqual) {
            afterEqual = false;
            displayString = "";
            numberString = "";
          }
          numberString += title;
          displayString = numberString;
        }
      } on FormatException catch (e) {
        operation = title;
      }
    });
  }

  calculate() {
    switch (operation) {
      case '+':
        result += double.parse(numberString);
        break;
      case '-':
        result -= double.parse(numberString);
        break;
      case '*':
        result *= double.parse(numberString);
        break;
      case '/':
        result /= double.parse(numberString);
        break;
      default:
        displayString = "spec1";
        break;
    }
    if (displayString == "spec1") {
      displayString = numberString;
      return;
    }
    if (result % 1 == 0) {
      int temp = result.toInt();
      numberString = temp.toString();
    } else {
      numberString = result.toString();
    }
    displayString = numberString;
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
                  createRow("1", "2", "3", "="),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}