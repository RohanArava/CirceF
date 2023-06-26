import 'package:flutter/material.dart';
import 'package:smoke/screens/reult2.dart';
import 'package:smoke/screens/search_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reading extends StatefulWidget {
  const Reading({super.key, required this.Name, required this.age});
  final String Name;
  final int age;
  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  var start = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: start
            ? Column(
                children: [
                  SizedBox(
                    height: 400,
                  ),
                  Center(
                    child: Text(
                      "In Progress",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return Search();
                        }));
                      },
                      child: Text("Click to cancel"))
                ],
              )
            : TextButton(
                onPressed: () {
                  setState(() {
                    start = true;
                  });
                  http
                      .get(Uri.parse("http://10.0.55.227:5005/reading"))
                      .then((response) {
                    var details = json.decode(response.body);
                    print(details);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Result2(
                          id: "122",
                          name: widget.Name,
                          sess: 2,
                          details: details);
                    }));
                  });
                },
                child: Text(
                  "Click to take reading",
                  style: TextStyle(color: Colors.green),
                )),
      ),
    );
  }
}
