import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCal(),
    );
  }
}

class SimpleCal extends StatefulWidget {
  @override
  _SimpleCalState createState() => _SimpleCalState();
}

class _SimpleCalState extends State<SimpleCal> {
  String result = "0";
  String equation = "0";
  cal(String buttontext) {
    print(buttontext);
    setState(() {
      if (buttontext == "C") {
        result = "0";
        equation = "0";
      } else if (buttontext == "<|") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttontext == "=") {
        try {
          Parser p = new Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  Widget buildButton(
      String buttontext, double buttonheight, Color buttonColor) {
    return Container(
      width: MediaQuery.of(context).size.width * .25,
      height: MediaQuery.of(context).size.height * buttonheight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => {
          cal(buttontext),
        },
        child: Text(
          buttontext,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              equation,
              style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w200),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          ),
          Container(
            child: Text(
              result,
              style: TextStyle(fontSize: 48.0),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          ),
          Expanded(child: Divider()),
          Row(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", .1, Colors.redAccent),
                        buildButton("<|", .1, Colors.blueAccent),
                        buildButton("/", .1, Colors.blueAccent),
                      ]),
                      TableRow(children: [
                        buildButton("9", .1, Colors.black38),
                        buildButton("8", .1, Colors.black38),
                        buildButton("7", .1, Colors.black38),
                      ]),
                      TableRow(children: [
                        buildButton("6", .1, Colors.black38),
                        buildButton("5", .1, Colors.black38),
                        buildButton("4", .1, Colors.black38),
                      ]),
                      TableRow(children: [
                        buildButton("3", .1, Colors.black38),
                        buildButton("2", .1, Colors.black38),
                        buildButton("1", .1, Colors.black38),
                      ]),
                      TableRow(children: [
                        buildButton("0", .1, Colors.black38),
                        buildButton("00", .1, Colors.black38),
                        buildButton(".", .1, Colors.black38),
                      ]),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("*", .1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", .1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", .1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", .2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
