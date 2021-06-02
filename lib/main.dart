import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/DemoModel.dart';
import 'package:dio/dio.dart';

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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Plans> plansList = [];
  DemoModel modelObj;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[50],
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Image.network(
              modelObj.logo,
              height: 120,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: Text(
                modelObj.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                modelObj.subtitle,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, right: 35),
              height: 1,
              color: Colors.red[900],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: plansList.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: plansList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardItem(index);
                      })
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  CardItem(int i) {
    Plans pobj = plansList[i];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.white,
                Colors.white,
                Colors.red[50],
                Colors.red[100],
              ],
            )),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.network(
                    pobj.image,
                    height: 80,
                    // width: 80,
                    fit: BoxFit.fitWidth,
                  ),
                  flex: 4,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      pobj.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  flex: 6,
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                pobj.tagLine,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    try {
      var response = await Dio()
          .get('https://run.mocky.io/v3/1b83e6fd-2c52-4e59-bee0-c6146c4d1df8');
      print(response);

      var resp = json.decode(response.toString());

      setState(() {
        modelObj = DemoModel.fromJson(resp);
        plansList = modelObj.plans.toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
