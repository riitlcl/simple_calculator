import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SecondRoute.dart';
class ForthRoute extends StatefulWidget  {

  @override
  _ForthRoute createState() => _ForthRoute();
}

class _ForthRoute extends State<ForthRoute> {

  var url = "";
  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.pink,
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );

  final _form = GlobalKey<FormState>();

  void writeData() async {
    _form.currentState!.save();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"data": cdate2}),
      );
    }
    catch (error) {
      throw error;
    }
  }

  void initState() {
    super.initState();
    readData();
  }

  bool isLoading = true;
  List<String> list = [];

  Future<void> readData() async {
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        list.add(blogData["data"]);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FireBase',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Testing"),
            ),
            body: isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          list[index],
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                  );
                }
            )
        )
    );
  }
}
