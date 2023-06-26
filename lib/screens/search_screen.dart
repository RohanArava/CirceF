import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smoke/screens/reading_screen.dart';
import 'package:smoke/screens/result_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/auth.dart';
import './selectsess_screen.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  static String route = "seascr";
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var suggestions = [];
  var _searchController = TextEditingController();
  var _nameController = TextEditingController();
  var _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var logout = Provider.of<Auth>(context).logout;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            width: size.width / 1.5,
            child: TextField(
                controller: _searchController,
                onChanged: (str) async {
                  print("here");
                  var response = await http.get(Uri.parse(
                      "http://10.0.55.227:5005/search/${str != '' ? str : '&'}"));
                  var body = json.decode(response.body);
                  print(body);
                  setState(() {
                    suggestions = [];
                    for (var value in (body["res"])) {
                      suggestions.add({
                        "id": value["id"],
                        "age": value["age"],
                        "name": value["name"],
                        "sessions": value["sessions"]
                      });
                    }
                  });
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    label: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 28),
                        children: [
                          TextSpan(
                            text: "Tap to Search ",
                            style: TextStyle(fontSize: 24),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.search, size: 28),
                          ),
                        ],
                      ),
                    ))),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Add a Person"),
                        content: Container(
                          height: 120,
                          child: Column(
                            children: [
                              TextField(
                                controller: _nameController,
                                decoration:
                                    InputDecoration(label: Text("Name")),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: _ageController,
                                decoration: InputDecoration(label: Text("Age")),
                              ),
                            ],
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.end,
                        actions: [
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return Reading(Name: _nameController.text,age: int.parse(_ageController.text),);
                                }));
                              },
                              child: Text("Add")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are You Sure You Want To Log Out?"),
                        actionsAlignment: MainAxisAlignment.end,
                        actions: [
                          TextButton(style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel")),
                          ElevatedButton(style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                logout();
                                Navigator.of(context).pushReplacementNamed("/");
                              },
                              child: Text("Log Out")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
          height: size.height / 1.1,
          child: suggestions.length == 0
              ? Center(
                  child: Container(
                      width: size.width / 1,
                      height: size.width / 1,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/heartbeat.png",
                                  width: size.width / 1.5),
                            ),
                            SizedBox(
                              height: size.width / 10,
                            ),
                            Text(
                              "Welcome To Circe Healthcare",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )),
                )
              : ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return SelectSess(
                                id: suggestions[index]["id"]!,
                                name: suggestions[index]["name"]!,
                                num: suggestions[index]["sessions"]!,
                              );
                            }));
                          },
                          title: Text(
                            suggestions[index]["name"]!,
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  })),
    );
  }
}
