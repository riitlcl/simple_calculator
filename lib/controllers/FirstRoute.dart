import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_calculator/controllers/ForthRoute.dart';
import 'package:simple_calculator/controllers/ThirdRoute.dart';
import 'package:simple_calculator/controllers/SecondRoute.dart';
import 'dart:math';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {

  late final int firstnum;
  late final int secondnum;
  late String texttodisplay = '';
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
            MaterialPageRoute(builder: (context) => SecondRoute()));
      }
      if (operatortoperform == 'FireB') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForthRoute()));
      }
      if (operatortoperform == 'HSTR') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThirdRoute()));
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
