import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ForthRoute.dart';
import 'SecondRoute.dart';
import 'ThirdRoute.dart';


class FirstRoute extends StatefulWidget {

   FirstRoute({Key? key,}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {

  late final int firstnum;
  late final int secondnum;
  String texttodisplay = '';
  late final String res;
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
      if (operatortoperform == 'FireB') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ForthRoute()));
      }
      if (operatortoperform == 'HSTR') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ThirdRoute()));
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
                custombutton('FireB'),
                custombutton('HSTR'),
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
