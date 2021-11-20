import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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

  late int firstnum;
  late int secondnum;
  String texttodisplay = '';
  late String res;
  late String operatortoperform;

  void btnclicked(String btnvalue) {
    if (btnvalue == 'C') {
      texttodisplay = '';
      firstnum = 0;
      secondnum = 0;
      res = '';
    }
    else if (
    btnvalue == '^' ||
    btnvalue == '+' ||
        btnvalue == '-' ||
        btnvalue == 'x' ||
        btnvalue == '/') {
      firstnum = int.parse(texttodisplay);
      res = '';
      operatortoperform = btnvalue;
    }
    else if (btnvalue == '=') {
      secondnum = int.parse(texttodisplay);
      if (operatortoperform == 'Con') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SecondRoute()));
      }
      if (operatortoperform == '^') {
        res = (pow(firstnum, secondnum)).toString();
      }
      if (operatortoperform == '+') {
        res = (firstnum + secondnum).toString();
      }
      if (operatortoperform == '-') {
        res = (firstnum - secondnum).toString();
      }
      if (operatortoperform == 'x') {
        res = (firstnum * secondnum).toString();
      }
      if (operatortoperform == '/') {
        res = (firstnum / secondnum).toString();
      }
    }
    else {
      res = int.parse(texttodisplay + btnvalue).toString();
    }

    setState(() {
      texttodisplay = res;
    });
  }

  // button class start
  Widget custombutton(String btnvalue) {
    return Expanded(
      child: OutlineButton(
        padding: EdgeInsets.all(20),
        onPressed: () => btnclicked(btnvalue),
        child: Text(
          '$btnvalue',
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
// button class end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$texttodisplay',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                custombutton('...'),
                custombutton('...'),
                custombutton('Con'),
                custombutton('^'),
              ],
            ),
            Row(
              children: <Widget>[
                custombutton('9'),
                custombutton('8'),
                custombutton('7'),
                custombutton('+'),
              ],
            ),
            Row(
              children: <Widget>[
                custombutton('6'),
                custombutton('5'),
                custombutton('4'),
                custombutton('-'),
              ],
            ),
            Row(
              children: <Widget>[
                custombutton('3'),
                custombutton('2'),
                custombutton('1'),
                custombutton('x'),
              ],
            ),
            Row(
              children: <Widget>[
                custombutton('C'),
                custombutton('0'),
                custombutton('='),
                custombutton('/'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget  {
  @override
  _SecondRoute createState() => _SecondRoute();}
class _SecondRoute extends State<SecondRoute> {
  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );


  late String _startMeasure;
  late String _convertedMeasure;
  late double _numberForm;
  late String _resultMessage;

  void initState() {
    _numberForm = 0;
    super.initState();
  }

  final List<String> _measures = [
    'meters',
    'kilometers',
     ];
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
      };

  dynamic _formulas = {
    '0': [1, 0.001 ],
    '1': [1000, 1],
  };

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from] as int;
    int nTo = _measuresMap[to] as int;
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
      '${_numberForm.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Converter"),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        children: [
      Spacer(),
          TextField(
          style: inputStyle,
            decoration: InputDecoration(
              hintText: "Please enter the value",
      ),
      onChanged: (text) {
          var rv = double.tryParse(text);
              if (rv != null) {
                setState(() {
      _numberForm = rv;
                });
              }
             },
            ),
      Spacer(),
      Row(
        children: [
          DropdownButton(
              style: inputStyle,
                hint: Text(
                        "Unit",
                      style: inputStyle,
                        ),
            items: _measures.map((String value) {
              return DropdownMenuItem<String>(
            value: value,
                child: Text(value),
                              );
              }).toList(),
              onChanged: (value) {
          setState(() {
          _startMeasure = value as String;
           });
            },
            value: _startMeasure,
          ),
          Spacer(),
        Icon(
        Icons.arrow_forward,
        color: Colors.teal,
          size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
    Spacer(),
        DropdownButton(
        hint: Text(
                "Unit",
              style: inputStyle,
            ),
            style: inputStyle,
            items: _measures.map((String value) {
          return DropdownMenuItem<String>(
          value: value,
        child: Text(
        value,
          style: inputStyle,
          ),
        );
        }).toList(),
        onChanged: (value) {
        setState(() {
          _convertedMeasure = value as String;
            });
          },
            value: _convertedMeasure,
    ),
    ],
    ),

        Spacer(
        flex: 1,
        ),
        RaisedButton(
        color: Colors.blue,
         child: Text('Convert', style: TextStyle(color: Colors.white)),
    onPressed: () {
    if (_startMeasure.isEmpty ||
    _convertedMeasure.isEmpty ||
    _numberForm == 0) {
    return;
    } else {
    convert(_numberForm, _startMeasure, _convertedMeasure);
    }
    },
    ),

    Spacer(
    flex: 1,
    ),
    Text((_resultMessage == null) ? '' : _resultMessage,
    style: labelStyle),
    Spacer(
    flex: 8,
    ),
  ]
    ),
    )
    );
  }
}