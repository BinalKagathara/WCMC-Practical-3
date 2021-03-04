import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String txt, date1 = "First Date", date2 = "Second Date", age = "";
  Timer t;
  bool isSwitched = false;
  DateTime dt1 = DateTime.now();
  DateTime dt2 = DateTime.now();
  var dateFormat = DateFormat('d/M/y');
  void fun() {
    t = Timer.periodic(
        Duration(
          seconds: 4,
        ), (t) {
      DateTime dt = DateTime.now();
      txt = "Drink Water.\nTime is ${dt.hour}:${dt.minute}:${dt.second}";
      Fluttertoast.showToast(
        msg: txt,
      );
    });
  }

  _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dt1,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: const Color(0x8A000000)),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != dt1)
      setState(() {
        dt1 = picked;
        date1 = (dateFormat.format(dt1));
      });
  }

  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dt2, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: const Color(0x8A000000)),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != dt2)
      setState(() {
        dt2 = picked;
        date2 = (dateFormat.format(dt2));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          '18IT045 : Practical 3',
          style: TextStyle(
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Drink Water Remainder",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoSwitch(
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        isSwitched = value;
                        value == false ? t.cancel() : fun();
                      });
                    },
                    activeColor: Colors.teal,
                    trackColor: Colors.black26,

                  ),
                ),
              ],
            ),
            SizedBox(height: 50),

            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: OutlineButton.icon(
                      onPressed: () => _selectDate1(context),
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20,
                      ),
                      label: Text(date1)),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: OutlineButton.icon(
                      onPressed: () => _selectDate2(context),
                      icon: Icon(
                        Icons.calendar_today,
                        size: 20,
                      ),
                      label: Text(date2)),
                )
              ],
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                if (dt1 is DateTime && dt2 is DateTime) {
                  var diff = dt2.difference(dt1).inDays;
                  int year = (diff ~/ 365);
                  int month = (diff % 365) ~/ 30;
                  int days = (diff % 365) % 30;
                  setState(() {
                    age = year.toString() +
                        " years " +
                        month.toString() +
                        " months " +
                        days.toString() +
                        " days";
                  });
                }
              },
              child: Text("Difference between two dates"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                age,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
