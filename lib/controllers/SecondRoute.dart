import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondRoute extends StatefulWidget  {
  @override
  _SecondRoute createState() => _SecondRoute();}
class _SecondRoute extends State<SecondRoute> {
  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  late String _startMeasure;
  late String _convertedMeasure;
  late double _numberForm;
  late String _resultMessage;

  get labelStyle => null;

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

String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
String tdata = DateFormat("HH:mm").format(DateTime.now());
