
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_calculator/controllers/SecondRoute.dart';


class ThirdRoute extends StatefulWidget  {


  @override
  _ThirdRoute createState() => _ThirdRoute();}

class _ThirdRoute extends State<ThirdRoute> {
  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.deepOrange,
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );



  SharedPreferences? preferences;

  int get firstnum => firstnum;

  int get secondnum => secondnum;

  String get res => res;

  String get operatortoperform => operatortoperform;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete((){
      setState(() {});
    });
  }

  Future<void> initializePreference() async{
    this.preferences = await SharedPreferences.getInstance();
    this.preferences?.setString("date", cdate2 + " " + tdata);
    this.preferences?.setInt("firstnum", firstnum);
    this.preferences?.setInt("secondnum", secondnum);
    this.preferences?.setString("res", res);
    this.preferences?.setString("btnvalue", operatortoperform);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${this.preferences?.getInt('firstnum') ?? 0} ${this.preferences?.getString('btnvalu') ?? 0} ${this.preferences?.getInt('secondnum') ?? 0} = ${this.preferences?.getString('res') ?? 0}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\n \n ${this.preferences?.getString("date")}',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}